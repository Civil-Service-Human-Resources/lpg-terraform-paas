module "subscription" {
	source = "../../modules/subscription"
	subscription_name = "CSL-Staging"
}

module "env" {
	source = "../module"

	env = "performance"
}