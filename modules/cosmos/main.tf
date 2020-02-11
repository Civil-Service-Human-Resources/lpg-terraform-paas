###### cosmos ######

resource "azurerm_cosmosdb_account" "test" {
  name                = "${var.cosmos_name}"
  location            = "${var.rg_location}"
  resource_group_name = "${var.rg_name}"
  offer_type          = "${var.cosmos_offer_type}"
  kind                = "MongoDB"

### ****CAREFUL**** - CAPABILITIES must only be run against Staging and Integration ###
/*
  capabilities {
    name = "EnableAggregationPipeline"
  }
*/
### ^^^^CAREFUL^^^^ ###

  consistency_policy {
    consistency_level = "${var.cosmos_consistency_policy_level}"
  }

  geo_location {
    location = "${var.cosmos_failover_policy_location}"
    failover_priority = 0
  }

  tags {
    environment = "${var.env_profile}"
  }
}

output "cosmos_password" {
  value = "${azurerm_cosmosdb_account.test.primary_master_key}"
}
output "cosmos_name" {
  value = "${azurerm_cosmosdb_account.test.name}"
}