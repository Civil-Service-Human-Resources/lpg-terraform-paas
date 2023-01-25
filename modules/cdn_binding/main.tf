locals {
  cdn_domain = "${var.cdn_name}.${var.domain}"
  cdn_profile_name = "cdn-blob-${var.cdn_name}"
  sa_name = var.cdn_name
}

data "azurerm_storage_account" "storage_account" {
  name = local.sa_name
  resource_group_name = var.rg_name
}

# endpoint

resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "cdne-${var.cdn_name}"
  profile_name        = local.cdn_profile_name
  location                 = "global"
  resource_group_name      = var.rg_name
  origin_host_header = data.azurerm_storage_container.storage_account.primary_web_host

  origin {
    name      = local.sa_name
    host_name = data.azurerm_storage_account.storage_account.primary_web_host
  }

  delivery_rule {
    name  = "EnforceHTTPS"
    order = 1

    request_scheme_condition {
      operator     = "Equal"
      match_values = ["HTTP"]
    }

    url_redirect_action {
      redirect_type = "Found"
      protocol      = "Https"
    }
  }
}

# DNS record

resource "azurerm_dns_cname_record" "cname" {
  for_each = toset(var.environment != "production" ? [var.domain] : [])
  
  zone_name = each.value
  resource_group_name = "lpgdomain"
  name = var.cdn_name
  target_resource_id = azurerm_cdn_endpoint.cdn_endpoint.id
  ttl = 3600
}

# domain

resource "azurerm_cdn_endpoint_custom_domain" "custom_domain" {
  name            = "cdn-domain-${var.cdn_name}"
  cdn_endpoint_id = azurerm_cdn_endpoint.cdn_endpoint.id
  host_name       = local.cdn_domain

  depends_on = [
    azurerm_dns_cname_record.cname
  ]

  cdn_managed_https {
    certificate_type = "Dedicated"
    protocol_type    = "ServerNameIndication"
  }
}
