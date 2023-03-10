module "subscription" {
	source = "../../modules/subscription"
	subscription_name = "CSL-Staging"
}

module "env" {
	source = "../module"

	rg_env = "perf"
	environment = "performance"
	location = "UKSouth"
}