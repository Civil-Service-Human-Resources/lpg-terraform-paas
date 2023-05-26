module "production-environment" {
    source = "../master"
    rg_name = "lpgprod"
	domain = "learn.civilservice.gov.uk"
	environment = "production"
}