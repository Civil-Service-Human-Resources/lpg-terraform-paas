data "azurerm_key_vault_certificate" "app_keyvault_cert" {
  name         = var.certificate_name
  key_vault_id = var.keyvault_id
}

resource "azurerm_app_service_certificate" "app_service_certificate" {
  name                = var.certificate_name
  resource_group_name = var.app_rg_name
  location            = var.app_location
  key_vault_secret_id = data.azurerm_key_vault_certificate.app_keyvault_cert.secret_id
}

resource "azurerm_app_service_certificate_binding" "app_service_cert_binding" {
  hostname_binding_id = var.app_custom_domain_verification_id
  certificate_id      = azurerm_app_service_certificate.app_service_certificate.id
  ssl_state           = "SniEnabled"
}