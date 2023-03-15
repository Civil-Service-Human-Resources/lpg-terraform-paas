resource "azurerm_dns_txt_record" "txt" {
  name                = join(".", ["_dnsauth", var.app_subdomain])
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group
  ttl                 = 3600

  record {
    value = var.domain_validation_token
  }
}

resource "azurerm_dns_cname_record" "cname" {
  depends_on = [azurerm_dns_txt_record.txt]

  name                = var.app_subdomain
  zone_name           = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group
  ttl                 = 3600
  record              = var.endpoint_hostname
}