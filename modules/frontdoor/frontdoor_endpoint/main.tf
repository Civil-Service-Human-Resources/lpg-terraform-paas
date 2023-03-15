resource "random_string" "random_suffix" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  name                     = "${var.app_subdomain}-${random_string.random_suffix.result}"
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id
}

output "id" {
  value = azurerm_cdn_frontdoor_endpoint.endpoint.id
}

output "host_name" {
  value = azurerm_cdn_frontdoor_endpoint.endpoint.host_name
}