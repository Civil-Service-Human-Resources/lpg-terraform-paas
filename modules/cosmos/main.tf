###### cosmos ######

resource "azurerm_cosmosdb_account" "test" {

  name                = var.cosmos_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  offer_type          = var.cosmos_offer_type
  kind                = "MongoDB"
  mongo_server_version  = "4.2"

  default_identity_type = "FirstPartyIdentity"


# AllowSelfServeUpgradeToMongo36 
  capabilities {
    name = "AllowSelfServeUpgradeToMongo36"
  }

# DisableRateLimitingResponses 
  capabilities {
    name = "DisableRateLimitingResponses"
  }

# Not sure why this one is now present, but it is after the upgrade
  capabilities {
    name = "EnableMongo"
  }
  
### ^^^^CAREFUL^^^^ ###
#
  consistency_policy {
    consistency_level = var.cosmos_consistency_policy_level
  }

  geo_location {
    location = var.cosmos_failover_policy_location
    failover_priority = 0
  }

  tags = {
    environment = var.env_profile
  }
}

output "cosmos_password" {
  value = azurerm_cosmosdb_account.test.primary_key
}
output "cosmos_name" {
  value = azurerm_cosmosdb_account.test.name
}
