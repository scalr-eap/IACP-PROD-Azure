resource "random_password" "mysql_pw" {
  length = 64
  special = false
  upper = true
  number = true
}

resource "azurerm_mysql_server" "iacp_mysql_server" {
  name                = "${var.name_prefix}-iacp-mysql-server"
  location            = var.location
  resource_group_name = azurerm_resource_group.iacp_rg.name

  administrator_login          = "scalr"
  administrator_login_password = random_password.mysql_pw.result

  version    = "5.7"

  sku_name   = "GP_Gen5_4"

  storage_mb            = 5120
  
  ssl_enforcement_enabled        = false
}

resource "azurerm_mysql_configuration" "iacp_mysql_cfg" {
  name                = "sql_mode"
  resource_group_name = azurerm_resource_group.iacp_rg.name
  server_name         = azurerm_mysql_server.iacp_mysql_server.name
  value               = "STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
}

resource "azurerm_mysql_database" "iacp_db_scalr" {
  name                = "scalr"
  resource_group_name = azurerm_resource_group.iacp_rg.name
  server_name         = azurerm_mysql_server.iacp_mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_database" "iacp_db_analytics" {
  name                = "analytics"
  resource_group_name = azurerm_resource_group.iacp_rg.name
  server_name         = azurerm_mysql_server.iacp_mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_virtual_network_rule" "iacp_mysql_vnet_rule" {
  name                = "${var.name_prefix}-iacp-mysql-vnet-rule"
  resource_group_name = azurerm_resource_group.iacp_rg.name
  server_name         = azurerm_mysql_server.iacp_mysql_server.name
  subnet_id           = azurerm_subnet.iacp_vm_subnet.id
}

/*
resource "azurerm_mysql_server" "iacp_mysql_server_backup" {
  name                = "${var.name_prefix}-iacp-mysql-server-bu"
  location            = var.location
  resource_group_name = azurerm_resource_group.iacp_rg.name

  administrator_login          = "scalr"
  administrator_login_password = random_password.mysql_pw.result

  version               = "5.7"

  sku_name              = "B_Gen5_2"
  storage_mb            = 5120

  create_mode               = "Replica"
  creation_source_server_id = azurerm_mysql_server.iacp_mysql_server.id

  ssl_enforcement_enabled   = false
}
*/

output "db_fqdn" {
  value = azurerm_mysql_server.iacp_mysql_server.fqdn
}

output mysql_creds {
  value = random_password.mysql_pw.result
}
