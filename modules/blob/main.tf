###### blob ######

resource "azurerm_storage_account" "blobsa" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.storage_account_location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication
  account_kind             = "Storage"

  enable_https_traffic_only = "false"

  tags = {
    environment = var.env_profile
  }
}

resource "azurerm_storage_container" "blobc" {
  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = var.container_accesstype
  depends_on            = [azurerm_storage_account.blobsa]
}

output "storage_connection_string" {
  value = azurerm_storage_account.blobsa.primary_connection_string
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
