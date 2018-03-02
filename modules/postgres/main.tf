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

  administrator_login          = "psqladminun"
  administrator_login_password = "H@Sh1CoR3!"
  version                      = "9.6"
  storage_mb                   = "51200"
  ssl_enforcement              = "Enabled"
}

