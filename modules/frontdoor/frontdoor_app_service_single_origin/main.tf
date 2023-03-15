resource "azurerm_cdn_frontdoor_origin_group" "app_service_origin_group" {
  name                     = var.name
  cdn_frontdoor_profile_id = var.frontdoor_profile_id
  session_affinity_enabled = true

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "app_service_origin" {
  name                          = "${var.name}-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.app_service_origin_group.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = var.app_service_fqdn
  http_port          = 80
  https_port         = 443
  origin_host_header = var.app_service_fqdn
  priority           = 1
  weight             = 1
}

resource "azurerm_cdn_frontdoor_route" "app_service_route" {
  name                          = "${var.name}-route"
  cdn_frontdoor_endpoint_id     = var.endpoint_id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.app_service_origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.app_service_origin.id]
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [var.custom_domain_id]
  link_to_default_domain          = false
}