locals {
	rg_name = "lpg${var.rg_env}"
	is_test_env = var.environment != "production"
	csl_domain = "learn.civilservice.gov.uk"
	domain = local.is_test_env ? "${var.environment}.${local.csl_domain}" : local.csl_domain
	cert_name = local.is_test_env ? "star-${var.environment}-learn-civil-service-gov-uk-2022" : "star-learn-civil-service-gov-uk-2022"
  apps = toset([
	"csl-service",
	"rustici-engine"
  ])
  cdns = toset([
	"cslsa${var.rg_env}"
  ])
}

# module "app_certificate_bindings" {
#   source = "../../modules/app_service_certificate_binding"

#   for_each = local.apps

#   app_name = each.value
#   app_rg_name = local.rg_name
#   domain = local.domain
#   certificate_name = local.cert_name
#   environment = var.environment
# }

module "cdn_bindings" {
	source = "../../modules/cdn_binding"

	for_each = local.cdns

	cdn_name = each.value
	rg_name = local.rg_name
	domain = local.domain
	environment = var.environment
	location = var.location
}