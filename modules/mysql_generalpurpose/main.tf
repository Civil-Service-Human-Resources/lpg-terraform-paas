###### mysql: General Purpose tier ######

resource "azurerm_mysql_server" "lpg_gp" {
  name                = "${var.mysql_name}"
  location            = "${var.mysql_location}"
  resource_group_name = "${var.rg_name}"

  sku {
    name = "${var.lpg_gp_skumname}"
    capacity = "${var.lpg_gp_capacity}"
    tier = "${var.lpg_gp_tier}"
    family = "${var.lpg_gp_family}"
  }

  storage_profile {
    storage_mb = "51200"
    backup_retention_days = 30
    geo_redundant_backup = "Disabled"
    auto_grow = "Disabled"
  }

  administrator_login          = "${var.mysql_admin_login}"
  administrator_login_password = "${var.mysql_admin_pass}"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"

  tags {
    environment = "${var.env_profile}"
  }
}