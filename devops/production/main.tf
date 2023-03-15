module "subscription" {
	source = "../../modules/subscription"
	subscription_name = "CSL-Production"
}

module "env" {
	source = "../module"

	rg_env = "prod"
	keyvault_users_group_object_id = var.keyvault_users_group_object_id
	cert_vault_name = "lpg-prod-ssl-keyvault"
	cert_vault_rg_name = "lpg-production-keyvault"
}