###### mysql ######

resource "azurerm_mysql_server" "lpg" {
  name                = "${var.mysql_name}"
  location            = "${var.mysql_location}"
  resource_group_name = "${var.rg_name}"

  sku {
    name = "B_Gen5_2"
    capacity = 2
    tier = "Basic"
    family = "Gen5"
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

resource "azurerm_mysql_database" "learner_record" {
  name                = "learner_record"
  resource_group_name = "${var.rg_name}"
  server_name         = "${var.mysql_name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_database" "identity" {
  name                = "identity"
  resource_group_name = "${var.rg_name}"
  server_name         = "${var.mysql_name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_database" "csrs" {
  name                = "csrs"
  resource_group_name = "${var.rg_name}"
  server_name         = "${var.mysql_name}"
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
