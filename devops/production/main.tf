locals {
	rg_name = "lpgprod"
	domain = "learn.civilservice.gov.uk"
	cert_name = "star-learn-civil-service-gov-uk-2022"
	environment = "production"
  apps = toset([
	"csl-service"
  ])
}

module "subscription" {
	source = "../../modules/subscription"

	subscription_name = var.subscription_name
}

module "app_certificate_bindings" {
  source = "../../modules/app_service_certificate_binding"

  for_each = local.apps

  app_name = each.value
  app_rg_name = local.rg_name
  domain = local.domain
  certificate_name = local.cert_name
  environment = local.environment
}