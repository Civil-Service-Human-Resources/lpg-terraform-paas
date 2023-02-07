module "subscription" {
	source = "../../modules/subscription"
	subscription_name = "CSL-Production"
}

module "env" {
	source = "../module"

	rg_env = "prod"
	env = "production"
}