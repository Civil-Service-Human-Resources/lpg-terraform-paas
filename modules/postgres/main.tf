###### postgres ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_postgresql_server" "test" {
  name                = "${var.postgres_name}"
  location            = "${var.postgres_location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  sku {
    name      = "${var.postgres_sku_name}"
    capacity  = "${var.postgres_sku_capacity}"
    tier      = "${var.postgres_sku_tier}"
  }

  administrator_login          = "${var.postgres_admin_login}"
  administrator_login_password = "${var.postgres_admin_pass}"
  version                      = "${var.postgres_version}"
  storage_mb                   = "${var.postgres_storage_mb}"
  ssl_enforcement              = "${var.postgres_ssl_enforcement}"

  tags {
    environment = "${var.env_profile}"
  }
}
