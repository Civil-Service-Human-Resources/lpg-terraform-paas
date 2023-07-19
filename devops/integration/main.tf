module "subscription" {
	source = "../../modules/subscription"
	subscription_name = "CSL-Staging"
}

module "env" {
	source = "../module"

	rg_env = "integration"
	cert_vault_name = "lpg-prod-kv"
	cert_vault_rg_name = "lpg-prod-keyvault"
}