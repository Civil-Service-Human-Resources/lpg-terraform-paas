module "subscription" {
	source = "../../modules/subscription"
	subscription_name = "CSL-Staging"
}

module "env" {
	source = "../module"

	rg_env = "perf"
	keyvault_users_group_object_id = var.keyvault_users_group_object_id
	cert_vault_name = "lpg-prod-kv"
	cert_vault_rg_name = "lpg-prod-keyvault"
}