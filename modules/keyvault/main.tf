data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "csl-vars-key-vault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }

    access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azuread_service_principal.MicrosoftWebApp.id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get"
    ]

    storage_permissions = [
      "Get"
    ]
  }
}