module "credentials" {
  source = "../credentials"
}

resource "azurerm_mysql_flexible_server" "server" {
  name                   = var.name
  resource_group_name    = var.rg_name
  location               = var.location
  
  version = "8.0.21"

  backup_retention_days  = 30
  sku_name               = var.sku

  administrator_login          = module.credentials.username
  administrator_password = module.credentials.password

  # This block ensures that once a random US/PW is used to create the mysql instance,
  # TF won't edit it again afterwards.
  lifecycle {
	ignore_changes = [
	  administrator_login,
	  administrator_password
	]
  }

  zone = 1

  storage {
	auto_grow_enabled = true
	size_gb = var.size_in_gb
  }  
}

# Databases

resource "azurerm_mysql_flexible_database" "databases" {
  for_each = var.databases

  name = each.value
  resource_group_name = azurerm_mysql_flexible_server.server.resource_group_name
  server_name = azurerm_mysql_flexible_server.server.name
  charset = "utf8mb3"
  collation = "utf8mb3_unicode_ci"
}

# Firewall

resource "azurerm_mysql_flexible_server_firewall_rule" "firewall_rules" {

  name = "AppService"
  resource_group_name = azurerm_mysql_flexible_server.server.resource_group_name
  server_name = azurerm_mysql_flexible_server.server.name
  start_ip_address = "0.0.0.0"
  end_ip_address = "0.0.0.0"
}