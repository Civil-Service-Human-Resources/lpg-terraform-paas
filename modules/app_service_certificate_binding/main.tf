locals {
  app_domain = "${var.app_name}.${var.domain}"
  app_service_name = "${var.app_rg_name}-${var.app_name}"
}

data "azurerm_linux_web_app" "app_service" {
  resource_group_name = var.app_rg_name
  name = local.app_service_name
}

# DNS record

resource "azurerm_dns_cname_record" "cname" {
  zone_name = var.domain
  resource_group_name = "lpgdomain"
  name = var.app_name
  record = data.azurerm_linux_web_app.app_service.default_hostname
  ttl = 3600
}

# Host

resource "azurerm_app_service_custom_hostname_binding" "custom_hostname" {
  hostname            = local.app_domain
  app_service_name    = data.azurerm_linux_web_app.app_service.name
  resource_group_name = data.azurerm_linux_web_app.app_service.resource_group_name

  # Ignore ssl_state and thumbprint as they are managed using
  # azurerm_app_service_certificate_binding.example
  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
  
  depends_on = [
	azurerm_dns_cname_record.cname
  ]
}

# Certificate

data "azurerm_app_service_certificate" "app_service_certificate" {
  name                = var.certificate_name
  resource_group_name = data.azurerm_linux_web_app.app_service.resource_group_name
}

resource "azurerm_app_service_certificate_binding" "app_service_cert_binding" {
  hostname_binding_id = azurerm_app_service_custom_hostname_binding.custom_hostname.id
  certificate_id      = data.azurerm_app_service_certificate.app_service_certificate.id
  ssl_state           = "SniEnabled"
}