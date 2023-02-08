locals {
  keyvault_access_apps = toset([
	"civil-servant-registry",
	"identity",
	"identity-management",
	"learning-locker-ui",
	"learning-locker-api-worker",
	"learning-locker-xapi",
	"lpg-learner-record",
	"lpg-learning-catalogue",
	"lpg-management",
	"lpg-report-service",
	"notification-service"
  ])
}

data "azurerm_client_config" "current" {}

data "azurerm_linux_web_app" "access_policy_app" {
  for_each = local.keyvault_access_apps
  name                = "lpg-${var.rg_name}-${each.value}"
  resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "LPGUIAppData" {
  name                = "lpg-${var.rg_name}-lpg-ui"
  resource_group_name = var.rg_name_lpg_ui
}


# data "azuread_group" "KeyVaultUsersGroup" {
#   display_name     = var.keyvault_users_group
#   security_enabled = true
# }

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
    object_id = data.azuread_group.KeyVaultUsersGroup.object_id

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

resource "azurerm_key_vault_access_policy" "lpg_ui_access_policy" {
  key_vault_id = azurerm_key_vault.csl-vars-key-vault.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_linux_web_app.LPGUIAppData.identity.0.principal_id  
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