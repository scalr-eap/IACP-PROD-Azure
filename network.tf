# RG
resource "azurerm_resource_group" "iacp_rg" {
    name     = "${var.name_prefix}-iacp-rg"
    location = var.location

    tags = var.tags
}

# Network
resource "azurerm_virtual_network" "iacp_network" {
    name                = "${var.name_prefix}-iacp-network"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = azurerm_resource_group.iacp_rg.name

    tags = var.tags
}

# Subnets
resource "azurerm_subnet" "iacp_vm_subnet" {
    name                 = "${var.name_prefix}-iacp-vm-subnet"
    resource_group_name  = azurerm_resource_group.iacp_rg.name
    virtual_network_name = azurerm_virtual_network.iacp_network.name
    address_prefixes     = [ "10.0.1.0/24" ]
    service_endpoints    = [ "Microsoft.Sql" ]
}

# Subnets
resource "azurerm_subnet" "iacp_bastion_subnet" {
    name                 = "${var.name_prefix}-iacp-bastion-subnet"
    resource_group_name  = azurerm_resource_group.iacp_rg.name
    virtual_network_name = azurerm_virtual_network.iacp_network.name
    address_prefixes     = [ "10.0.2.0/24" ]
}

# Public IP for LB
resource "azurerm_public_ip" "iacp_public_ip_lb" {
    name                         = "${var.name_prefix}-iacp-ip-lb"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.iacp_rg.name
    allocation_method            = "Static"
    domain_name_label            = "${var.name_prefix}iacp"
    sku                          = "Standard"

    tags = var.tags
}

# Public IP for Bastion
resource "azurerm_public_ip" "iacp_public_ip_bastion" {
    name                         = "${var.name_prefix}-iacp-ip-bastion"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.iacp_rg.name
    allocation_method            = "Static"
    domain_name_label            = "${var.name_prefix}iacp-bastion"
    sku                          = "Standard"

    tags = var.tags
}

# Load Balancer. Included here as it's closely linked to all the network stuff

resource "azurerm_lb" "iacp_lb" {
 name                = "${var.name_prefix}-iacp-lb"
 location            = var.location
 resource_group_name = azurerm_resource_group.iacp_rg.name
 sku                 = "standard"

 frontend_ip_configuration {
   name                 = "PublicIPAddress"
   public_ip_address_id = azurerm_public_ip.iacp_public_ip_lb.id
 }
}


resource "azurerm_lb_backend_address_pool" "iacp_bap" {
 resource_group_name = azurerm_resource_group.iacp_rg.name
 loadbalancer_id     = azurerm_lb.iacp_lb.id
 name                = "${var.name_prefix}-BackEndAddressPool"
}

resource "azurerm_lb_outbound_rule" "iacp_lb_or" {
  resource_group_name     = azurerm_resource_group.iacp_rg.name
  loadbalancer_id         = azurerm_lb.iacp_lb.id
  name                    = "OutboundRule"
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.iacp_bap.id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}

resource "azurerm_lb_rule" "iacp_lb_rule" {
  resource_group_name            = azurerm_resource_group.iacp_rg.name
  loadbalancer_id                = azurerm_lb.iacp_lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  disable_outbound_snat          = true
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.iacp_bap.id
}

# NIC for VMs
resource "azurerm_network_interface" "iacp_nic" {
    count                     = var.server_count
    name                      = "${var.name_prefix}-iacp-nic-${count.index}"
    location                  = var.location
    resource_group_name       = azurerm_resource_group.iacp_rg.name

    ip_configuration {
        name                          = "${var.name_prefix}-iacp-nic-cfg-${count.index}"
        subnet_id                     = azurerm_subnet.iacp_vm_subnet.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = var.tags
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_pool" {
  count                   = var.server_count
  network_interface_id    = element(azurerm_network_interface.iacp_nic.*.id,count.index)
  ip_configuration_name   = "${var.name_prefix}-iacp-nic-cfg-${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.iacp_bap.id
}

# NIC for Bastion
resource "azurerm_network_interface" "iacp_bastion_nic" {
    name                      = "${var.name_prefix}-iacp-bastion-nic"
    location                  = var.location
    resource_group_name       = azurerm_resource_group.iacp_rg.name

    ip_configuration {
        name                          = "${var.name_prefix}-iacp-bastion-nic-cfg"
        subnet_id                     = azurerm_subnet.iacp_bastion_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.iacp_public_ip_bastion.id
        primary                       = true
    }

    tags = var.tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "iacp_nisga" {
    count                     = var.server_count
    network_interface_id      = element(azurerm_network_interface.iacp_nic.*.id, count.index)
    network_security_group_id = azurerm_network_security_group.iacp_sg.id
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "iacp_nisgb" {
    network_interface_id      = azurerm_network_interface.iacp_bastion_nic.id
    network_security_group_id = azurerm_network_security_group.iacp_sg.id
}

resource "azurerm_subnet_network_security_group_association" "iacp_nsga_vm" {
    subnet_id                 = azurerm_subnet.iacp_vm_subnet.id
    network_security_group_id = azurerm_network_security_group.iacp_sg.id
}

resource "azurerm_subnet_network_security_group_association" "iacp_nsga_bastion" {
    subnet_id                 = azurerm_subnet.iacp_bastion_subnet.id
    network_security_group_id = azurerm_network_security_group.iacp_sg.id
}