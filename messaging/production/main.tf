module "subscription" {
	source = "../../modules/subscription"
	subscription_name = "CSL-Production"
}

module "env" {
	source = "../module"
	env = "production"
}