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

# CSL Jobs

resource "azurerm_storage_account" "csl_jobs_sa" {
  name                     = "cslfasa${var.rg_env}"
  resource_group_name      = azurerm_resource_group.devops_rg.name
  location                 = azurerm_resource_group.devops_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "csl_jobs_asp" {
  name                = "sp-csl-jobs-${var.rg_env}"
  location            = azurerm_resource_group.devops_rg.location
  resource_group_name = azurerm_resource_group.devops_rg.name
  os_type             = "Windows"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "csl_jobs_function_app" {
	location            = azurerm_resource_group.devops_rg.location
	name 				= "csl-jobs-${var.rg_env}"
	resource_group_name = azurerm_resource_group.devops_rg.name
	service_plan_id			   = azurerm_service_plan.csl_jobs_asp.id
    storage_account_name       = azurerm_storage_account.csl_jobs_sa.name
    storage_account_access_key = azurerm_storage_account.csl_jobs_sa.primary_access_key

	site_config {
		app_scale_limit                   = 200
		ftps_state                        = "FtpsOnly"
		load_balancing_mode               = "LeastRequests"
		managed_pipeline_mode             = "Integrated"
		minimum_tls_version               = "1.2"
		scm_minimum_tls_version           = "1.2"

		application_stack {
			node_version 					  = "~16"
		}

		cors {
			allowed_origins = [
				"https://portal.azure.com",
			]
			support_credentials = false
		}
	}

	timeouts {}

	## Terraform doesn't know about the new node ~18 version yet,
	## so we need to set it to 16, update manually in Azure portal
	## and tell TF to ignore any changes to the config thereafter.
	##
	## app_settings are ignored as TF will try to scrub some important
	## values out after deployment.
	lifecycle {
	  ignore_changes = [ 
		site_config[0].application_stack[0].node_version,
		app_settings
	   ]
	}
}

# Keyvaults

data "azuread_group" "keyvault_users_group" {
  display_name     = "CSL KeyVault users"
  security_enabled = true
}

module "secrets_vault" {
	source = "../../modules/keyvault"

	name = "kv-lpg${var.rg_env}-vars"
	app_service_managed_id_object_id = azurerm_user_assigned_identity.managed_app_service_identity.principal_id
	keyvault_users_group_object_id = data.azuread_group.keyvault_users_group.object_id
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