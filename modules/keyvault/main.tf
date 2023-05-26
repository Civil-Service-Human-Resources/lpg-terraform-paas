resource "azurerm_key_vault" "csl_vars_key_vault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "dev_group_access_policy" {
	key_vault_id = azurerm_key_vault.csl_vars_key_vault.id
	tenant_id = var.tenant_id
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
  key_vault_id = azurerm_key_vault.csl_vars_key_vault.id
  tenant_id = var.tenant_id
  object_id = var.app_service_managed_id_object_id
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