module "credentials" {
  source = "../credentials"
}

resource "azurerm_postgresql_flexible_server" "server" {
  name                   = var.name
  resource_group_name    = var.rg_name
  location               = var.location
  version                = "16"
  administrator_login    = module.credentials.username
  administrator_password = module.credentials.password
  zone                   = "1"

  # This block ensures that once a random US/PW is used to create the mysql instance,
  # TF won't edit it again afterwards.
  lifecycle {
	ignore_changes = [
	  administrator_login,
	  administrator_password
	]
  }

  storage_mb = var.size_in_mb
  sku_name   = var.sku

}

# Databases

resource "azurerm_postgresql_flexible_server_database" "databases" {
  for_each = var.databases

  name = each.value
  server_id = azurerm_postgresql_flexible_server.server.id
  charset = "UTF8"
  collation = "en_GB.utf8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

# Firewall

resource "azurerm_postgresql_flexible_server_firewall_rule" "firewall_rules" {

  name = "AppService"
  server_id = azurerm_postgresql_flexible_server.server.id
  start_ip_address = "0.0.0.0"
  end_ip_address = "0.0.0.0"
}