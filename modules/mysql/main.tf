###### mysql ######

resource "azurerm_mysql_server" "lpg" {
  name                = "${var.mysql_name}"
  location            = "${var.mysql_location}"
  resource_group_name = "${var.rg_name}"

  sku {
    name = "MYSQLB50"
    capacity = 50
    tier = "Basic"
  }

  administrator_login          = "${var.mysql_admin_login}"
  administrator_login_password = "${var.mysql_admin_pass}"
  version                      = "5.7"
  storage_mb                   = "51200"
  ssl_enforcement              = "Enabled"

  tags {
    environment = "${var.env_profile}"
  }
}