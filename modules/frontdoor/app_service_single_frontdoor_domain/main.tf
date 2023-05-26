# Custom domain for the frontdoor - this will be the externally facing URL

resource "azurerm_cdn_frontdoor_custom_domain" "custom_domain" {
  name                     = var.app_subdomain
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
  dns_zone_id              = var.dns_zone_id
  host_name                = "${var.app_subdomain}.${var.domain}"

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}

# Endpoint for the CDN, required to join everything up at the end

module "endpoint" {
	source = "../frontdoor_endpoint"
	app_subdomain = var.app_subdomain
	cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
}

# Rustici engine app pool

module "app_service_origin" {
	source = "../frontdoor_app_service_single_origin"

	name = var.app_subdomain
	frontdoor_profile_id = var.cdn_frontdoor_profile_id
	app_service_fqdn = var.app_service_hostname
	endpoint_id = module.endpoint.id
	custom_domain_id = azurerm_cdn_frontdoor_custom_domain.custom_domain.id
}

# DNS Resources

module "dns_records" {
	depends_on = [module.app_service_origin]
	# Below is essentially an IF statement to ensure we don't try to create
	# DNS records for production (as we don't have access to the prod DNS server..)
	for_each = toset(var.env_profile != "prod" ? [var.domain] : [])
	source = "../frontdoor_dns_records"

	domain_validation_token = azurerm_cdn_frontdoor_custom_domain.custom_domain.validation_token
	app_subdomain = var.app_subdomain
	dns_zone_name = var.domain
	dns_zone_resource_group = var.dns_zone_resource_group
	endpoint_hostname = module.endpoint.host_name
}