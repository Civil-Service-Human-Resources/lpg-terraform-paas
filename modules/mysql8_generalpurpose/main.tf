###### mysql: General Purpose tier ######

resource "azurerm_mysql_flexible_server" "lpg_gp8" {
  name                = var.mysql_name
  location            = var.mysql_location
  resource_group_name = var.rg_name

  sku_name = var.lpg_gp_skuname
  backup_retention_days = 30
  geo_redundant_backup_enabled = true

  storage {
    auto_grow_enabled = false
    size_gb = var.mysql_storage
  }

  administrator_login          = var.mysql_admin_login
  administrator_password       = var.mysql_admin_pass
  version                      = "8.0.21"

  tags = {
    environment = var.env_profile
  }
}