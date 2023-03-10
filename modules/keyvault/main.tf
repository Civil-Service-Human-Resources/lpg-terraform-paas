locals {
  keyvault_access_apps = {
	"lpg-${var.rg_name}-lpg-ui" = var.rg_name_lpg_ui
	"lpg-${var.rg_name}-civil-servant-registry" = var.rg_name
	"lpg-${var.rg_name}-identity" = var.rg_name
	"lpg-${var.rg_name}-identity-management" = var.rg_name
	"lpg-${var.rg_name}-lpg-learner-record" = var.rg_name
	"lpg-${var.rg_name}-lpg-learning-catalogue" = var.rg_name
	"lpg-${var.rg_name}-lpg-management" = var.rg_name
	"lpg-${var.rg_name}-lpg-report-service" = var.rg_name
	"lpg-${var.rg_name}-notification-service" = var.rg_name
	"${var.rg_name}-csl-service" = var.rg_name
	"${var.rg_name}-rustici-engine" = var.rg_name
  }
}

data "azurerm_client_config" "current" {}

data "azurerm_linux_web_app" "access_policy_app" {
  for_each = local.keyvault_access_apps
  name                = each.key
  resource_group_name = each.value
}

resource "azurerm_key_vault" "csl-vars-key-vault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "dev_group_access_policy" {
	key_vault_id = azurerm_key_vault.csl-vars-key-vault.id
	tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.keyvault_users_group_object_id

    key_permissions = [
      "Get"
    ]

    secret_permissions = [
      "Get", 
      "List", 
      "Set", 
      "Delete", 
      "Recover", 
      "Backup", 
      "Restore"
    ]

    storage_permissions = [
      "Get"
    ]
  
}

resource "azurerm_key_vault_access_policy" "app_access_policy" {
  for_each = data.azurerm_linux_web_app.access_policy_app
  key_vault_id = azurerm_key_vault.csl-vars-key-vault.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = each.value.identity.0.principal_id
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