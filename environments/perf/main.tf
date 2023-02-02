module "performance-environment" {
    source = "../master"
    rg_name = "lpgperf"
	domain = "performance.learn.civilservice.gov.uk"
	environment = "performance"
}