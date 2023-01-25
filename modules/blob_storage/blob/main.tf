###### blob ######

locals {
  blob_sa_name = "cslsa${var.name}"
}

resource "azurerm_storage_account" "blobsa" {
  name                     = local.blob_sa_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.replication
  account_kind             = "Storage"

  enable_https_traffic_only = "false"
}

resource "azurerm_storage_container" "blobc" {
  for_each 				= var.containers
  name                  = each.value
  storage_account_name  = azurerm_storage_account.blobsa.name
  container_access_type = "private"
  depends_on            = [azurerm_storage_account.blobsa]
}

resource "azurerm_cdn_profile" "cdn" {
  location                 = "global"
  resource_group_name      = var.rg_name
  name                = "cdn-blob-${azurerm_storage_account.blobsa.name}"
  sku                 = "Standard_Microsoft"
}

# output

output "storage_connection_string" {
  value = azurerm_storage_account.blobsa.primary_connection_string
}

output "storage_account_host" {
  value = azurerm_storage_account.blobsa.primary_web_host
}