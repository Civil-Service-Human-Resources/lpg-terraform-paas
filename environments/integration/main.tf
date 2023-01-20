module "integration-environment" {
    source = "../master"
    rg_name = "lpgintegration"
    rg_prefix = "lpg"
	domain = "integration.learn.civilservice.gov.uk"
	environment = "integration"
}