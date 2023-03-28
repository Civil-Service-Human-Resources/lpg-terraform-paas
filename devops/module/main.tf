data "azurerm_client_config" "current" {}

# IDs

resource "azurerm_resource_group" "devops_rg" {
  name = "rg-devops-${var.rg_env}"
  location = "UKSouth"
}

resource "azurerm_user_assigned_identity" "managed_app_service_identity" {
  location            = azurerm_resource_group.devops_rg.location
  name                = "uai-${var.rg_env}"
  resource_group_name = azurerm_resource_group.devops_rg.name
}

# Keyvaults

module "secrets_vault" {
	source = "../../modules/keyvault"

	name = "kv-lpg${var.rg_env}-vars"
	app_service_managed_id_object_id = azurerm_user_assigned_identity.managed_app_service_identity.principal_id
	keyvault_users_group_object_id = var.keyvault_users_group_object_id
	rg_name = azurerm_resource_group.devops_rg.name
	location = azurerm_resource_group.devops_rg.location
	tenant_id = data.azurerm_client_config.current.tenant_id
}

## Cert vault - should be managed by TF, however the test environments all share the
## same KV at the moment. Can be fixed at a later date

data "azurerm_key_vault" "cert_vault" {
  name = var.cert_vault_name
  resource_group_name = var.cert_vault_rg_name
}

resource "azurerm_key_vault_access_policy" "cert_access_policy" {
	key_vault_id = data.azurerm_key_vault.cert_vault.id
	tenant_id = data.azurerm_client_config.current.tenant_id
	object_id = azurerm_user_assigned_identity.managed_app_service_identity.principal_id
	secret_permissions = [
		"Get"
	]  
	certificate_permissions = [
		"Get",
		"Import"
	]
}