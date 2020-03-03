###### cosmos ######

resource "azurerm_cosmosdb_account" "test" {
  name                = var.cosmos_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  offer_type          = var.cosmos_offer_type
  kind                = "MongoDB"

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
  value = azurerm_cosmosdb_account.test.primary_master_key
}
output "cosmos_name" {
  value = azurerm_cosmosdb_account.test.name
}

resource "azurerm_storage_account" "assets" {
  name                = "lpg${var.env_profile}blobassets"
  resource_group_name      = var.rg_name
  location                 = "westeurope"
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication
  account_kind             = "Storage"

  enable_https_traffic_only = "false"

  tags = {
    environment = var.env_profile
  }
}

resource "azurerm_storage_container" "assets" {
  name                  = "assets"
  storage_account_name  = "lpg${var.env_profile}blobassets"
  container_access_type = var.container_accesstype
  depends_on            = [azurerm_storage_account.assets]
}

resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "assetsprofile${var.env_profile}"
  location            = "westeurope"
  resource_group_name = var.rg_name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "assetscdnendpoint${var.env_profile}"
  profile_name        = "assetsprofile${var.env_profile}"
  location            = "westeurope"
  resource_group_name = var.rg_name

  origin {
    name      = "lpg${var.env_profile}blobassets"
    host_name = "lpg${var.env_profile}blobassets.blob.core.windows.net"
  }
  depends_on = [azurerm_storage_account.assets, azurerm_cdn_profile.cdn_profile]
}