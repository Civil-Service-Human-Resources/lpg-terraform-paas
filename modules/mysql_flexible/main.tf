resource "azurerm_mysql_flexible_server" "example" {
  name                   = var.name
  resource_group_name    = var.rg_name
  location               = var.location

  backup_retention_days  = 30
  sku_name               = var.sku

  administrator_login = "f35gd"
  administrator_password = "dl20v8L*"

  zone = 1

  storage {
	auto_grow_enabled = true
	size_gb = var.size_in_gb
  }

  version = "8.0.21"
}