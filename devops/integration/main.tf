module "subscription" {
	source = "../../modules/subscription"
	subscription_name = "CSL-Staging"
}

module "env" {
	source = "../module"

	rg_env = "integration"
	environment = "integration"
	location = "UKSouth"
}