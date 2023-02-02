locals {
    rg_name = "lpgstaging"
	domain = "staging.learn.civilservice.gov.uk"
	environment = "staging"
}

module "staging-environment" {
    source = "../master"
    rg_name = "lpgstaging"
	domain = "staging.learn.civilservice.gov.uk"
	environment = "staging"
}