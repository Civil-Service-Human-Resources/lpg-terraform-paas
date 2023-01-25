module "subscription" {
	source = "../../modules/subscription"

	subscription_name = var.subscription_name
}

module "env" {
	source = "../module"

	rg_env = "prod"
	env = "production"
}