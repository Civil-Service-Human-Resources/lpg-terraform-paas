###### cosmos ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_cosmosdb_account" "test" {
  name                = "${var.cosmos_name}"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  offer_type          = "${var.cosmos_offer_type}"
  kind                = "MongoDB"

  consistency_policy {
    consistency_level = "${var.cosmos_consistency_policy_level}"
  }

  failover_policy {
    location = "${var.cosmos_failover_policy_location}"
    priority = 0
  }
}