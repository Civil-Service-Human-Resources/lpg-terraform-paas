resource "azurerm_cdn_frontdoor_origin_group" "cdn_origin_group" {
  name                     = var.name
  cdn_frontdoor_profile_id = var.frontdoor_profile_id
  session_affinity_enabled = true

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "cdn_origin" {
  name                          = "${var.name}-origin"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_origin_group.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = var.blob_storage_fqdn
  http_port          = 80
  https_port         = 443
  origin_host_header = var.blob_storage_fqdn
  priority           = 1
  weight             = 1
}

resource "azurerm_cdn_frontdoor_route" "cdn_route" {
  name                          = "${var.name}-route"
  cdn_frontdoor_endpoint_id     = var.endpoint_id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.cdn_origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.cdn_origin.id]
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = var.cdn_paths
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_origin_path = "/${var.blob_container}"

  cdn_frontdoor_custom_domain_ids = [var.custom_domain_id]
  link_to_default_domain          = false
  cache {
          compression_enabled           = true
          content_types_to_compress     = [
              "application/eot",
              "application/font",
              "application/font-sfnt",
              "application/javascript",
              "application/json",
              "application/opentype",
              "application/otf",
              "application/pkcs7-mime",
              "application/truetype",
              "application/ttf",
              "application/vnd.ms-fontobject",
              "application/xhtml+xml",
              "application/xml",
              "application/xml+rss",
              "application/x-font-opentype",
              "application/x-font-truetype",
              "application/x-font-ttf",
              "application/x-httpd-cgi",
              "application/x-javascript",
              "application/x-mpegurl",
              "application/x-opentype",
              "application/x-otf",
              "application/x-perl",
              "application/x-ttf",
              "font/eot",
              "font/ttf",
              "font/otf",
              "font/opentype",
              "image/svg+xml",
              "text/css",
              "text/csv",
              "text/html",
              "text/javascript",
              "text/js",
              "text/plain",
              "text/richtext",
              "text/tab-separated-values",
              "text/xml",
              "text/x-script",
              "text/x-component",
              "text/x-java-source",
            ]
          query_string_caching_behavior = "UseQueryString"
          query_strings                 = []
        }

}
