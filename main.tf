#terraform {
#  backend "remote" {
#    hostname = "my.scalr.com"
#    organization = "org-sfgari365m7sck0"
#    workspaces {
#      name = "iacp-ha-install"
#    }
#  }
#}


locals {
    license_file         = "./license/license.json"

  # Currently forces server_count = 1. When multiple servers allowed will limit to the number of subnets
#  server_count         = min(length(data.aws_subnet_ids.scalr_ids),var.server_count,1)
}

locals {
  linux_types = [ 
    "ubuntu-16.04",
    "centos-7",
    "centos-8",
    "rhel-7",
    "rhel-8"
   ]
  offers = [ 
    "UbuntuServer", #CANONICAL
    "CentOS",
    "CentOS",
    "RHEL",
    "RHEL",
    ]
  skus = [ 
    "16.04.0-LTS",
    "7.7",
    "8_1",
    "7.7",
    "8.1"
   ]
  publishers = [ 
    "canonical", #CANONICAL
    "OpenLogic",
    "OpenLogic",
    "RedHat",
    "RedHat",
    ]
  users = [
    "ubuntu",
    "centos",
    "centos",
    "scalr",
    "scalr"
  ]
}

provider "azurerm" {
  version = "=2.16.0"
  features {}
}

###############################
#
# Bastion host
#

resource "azurerm_linux_virtual_machine" "iacp_bastion" {
  name                  = "${var.name_prefix}-iacp-bastion"
  location              = var.location
  resource_group_name   = azurerm_resource_group.iacp_rg.name
  network_interface_ids = [ azurerm_network_interface.iacp_bastion_nic.id ]
  size                  = "Standard_B1ls"

  os_disk {
      name              = "${var.name_prefix}-iacp-bastion-osdisk"
      caching           = "ReadWrite"
      storage_account_type = "Premium_LRS"
  }

  source_image_reference {
      publisher = element(local.publishers,index(local.linux_types,var.linux_type))
      offer     = element(local.offers,index(local.linux_types,var.linux_type))
      sku       = element(local.skus,index(local.linux_types,var.linux_type))
      version   = "latest"
  }

  admin_username = element(local.users,index(local.linux_types,var.linux_type))
  disable_password_authentication = true
      
  admin_ssh_key {
      username       = element(local.users,index(local.linux_types,var.linux_type))
      public_key     = file("~/.ssh/id_rsa.pub")
  }

  tags = merge(
    map( "Name", "${var.name_prefix}-iacp-bastion"),
    var.tags )
  
}

###############################
#
# Availability set

resource "azurerm_availability_set" "iacp_av_set" {
 name                         = "${var.name_prefix}-iacp-av-set"
 location                     = var.location
 resource_group_name          = azurerm_resource_group.iacp_rg.name
 platform_fault_domain_count  = var.server_count
 platform_update_domain_count = var.server_count
 managed                      = true
}
###############################
#
# Scalr Server
#

resource "azurerm_linux_virtual_machine" "iacp_server" {
  count                 = var.server_count
  name                  = "${var.name_prefix}-iacp-server-${count.index}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.iacp_rg.name
  availability_set_id   = azurerm_availability_set.iacp_av_set.id
  network_interface_ids = [element(azurerm_network_interface.iacp_nic.*.id, count.index)]
  size                  = var.instance_size

  os_disk {
      name              = "${var.name_prefix}-iacp-osdisk-${count.index}"
      caching           = "ReadWrite"
      storage_account_type = "Premium_LRS"
  }

  source_image_reference {
      publisher = element(local.publishers,index(local.linux_types,var.linux_type))
      offer     = element(local.offers,index(local.linux_types,var.linux_type))
      sku       = element(local.skus,index(local.linux_types,var.linux_type))
      version   = "latest"
  }

  admin_username = element(local.users,index(local.linux_types,var.linux_type))
  disable_password_authentication = true
      
  admin_ssh_key {
      username       = element(local.users,index(local.linux_types,var.linux_type))
      public_key     = file("~/.ssh/id_rsa.pub")
  }

  tags = merge(
    map( "Name", "${var.name_prefix}-iacp-server-${count.index}"),
    var.tags )
  
}

resource "azurerm_managed_disk" "iacp_disk" {
  count                = var.server_count
  name                 = "${var.name_prefix}-iacp-data-disk-${count.index}"
  location             = var.location
  resource_group_name  = azurerm_resource_group.iacp_rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "50"

  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "iacp_attach" {
  count              = var.server_count
  managed_disk_id    = element(azurerm_managed_disk.iacp_disk.*.id, count.index)
  virtual_machine_id = element(azurerm_linux_virtual_machine.iacp_server.*.id, count.index)
  lun                = "10"
  caching            = "ReadWrite"
}

## Certificate

resource "tls_private_key" "scalr_pk" {
  algorithm = "RSA"
}

locals {
  dns_name = var.public == true ? azurerm_public_ip.iacp_public_ip_lb.fqdn : "${azurerm_lb.iacp_lb.name}.${azurerm_public_ip.iacp_public_ip_lb.fqdn}"
}

resource "tls_self_signed_cert" "scalr_cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.scalr_pk.private_key_pem

  subject {
    common_name  = local.dns_name
    organization = "Scalr"
  }

  validity_period_hours = 336

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "null_resource" "install_scalr" {
  count      = var.server_count
  depends_on = [azurerm_linux_virtual_machine.iacp_server,azurerm_virtual_machine_data_disk_attachment.iacp_attach,azurerm_mysql_database.iacp_db_analytics,azurerm_mysql_database.iacp_db_scalr,azurerm_mysql_virtual_network_rule.iacp_mysql_vnet_rule]
  
  connection {
        host	            = element(azurerm_linux_virtual_machine.iacp_server.*.private_ip_address,count.index)
        type              = "ssh"
        user              = element(local.users,index(local.linux_types,var.linux_type))
        private_key       = file("~/.ssh/id_rsa")
        timeout           = "20m"
        bastion_host      = azurerm_linux_virtual_machine.iacp_bastion.public_ip_address
        bastion_host_key  = file("~/.ssh/id_rsa.pub")
  }

  provisioner "file" {
        source = local.license_file
        destination = "/var/tmp/license.json"
  }

  provisioner "file" {
      source = "./SCRIPTS/scalr_install.sh"
      destination = "/var/tmp/scalr_install.sh"
  }

  provisioner "file" {
        content     = tls_self_signed_cert.scalr_cert.cert_pem
        destination = "/var/tmp/my.crt"
  }

  provisioner "file" {
        content     = tls_private_key.scalr_pk.private_key_pem
        destination = "/var/tmp/my.key"
  }

  # Temp db schema stuff

  provisioner "file" {
      source = "./SQL/analytics_data.sql"
      destination = "/var/tmp/analytics_data.sql"
  }

  provisioner "file" {
      source = "./SQL/analytics_structure.sql"
      destination = "/var/tmp/analytics_structure.sql"
  }

  provisioner "file" {
      source = "./SQL/data.sql"
      destination = "/var/tmp/data.sql"
  }

  provisioner "file" {
      source = "./SQL/structure.sql"
      destination = "/var/tmp/structure.sql"
  }

  provisioner "remote-exec" {
      inline = [
        "chmod +x /var/tmp/scalr_install.sh",
        "sudo /var/tmp/scalr_install.sh '${var.token}' ${local.dns_name} ${azurerm_mysql_server.iacp_mysql_server.fqdn} ${random_password.mysql_pw.result} ${count.index}"
      ]
  }
}

output "dns_name" {
  value = "https://${local.dns_name}"
}

output "bastion_ip" {
  value = azurerm_linux_virtual_machine.iacp_bastion.public_ip_address
}

