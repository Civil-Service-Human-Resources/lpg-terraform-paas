locals = {
	app_rg = "lpg-lpgintegration"
	domain = "integration.learn.civilservice.gov.uk"
	apps = [
		"csl-service"
	]
}

## Web apps

data "azurerm_linux_web_app" "web_apps" {
  for_each = local.apps
  name = "${local.app_rg}-${each.key.portal_name}"
  resource_group_name = local.app_rg
}

## Certificate access

data "azurerm_key_vault" "certificate_keyvault" {
	name = var.certificate_keyvault_name
	resource_group_name = var.certificate_keyvault_rg
}

resource "azurerm_key_vault_access_policy" "app_kv_ap" {
	
  for_each = data.azurerm_linux_web_app.web_apps

  key_vault_id = module.secret_keyvault.kv_id
  object_id = each.value.identity.0.principal_id
  tenant_id = each.value.identity.0.tenant_id

  secret_permissions = [
    "Get"
  ]

  certificate_permissions = [
	"Get"
  ]
}

# Certificate

module "certificate_binding" {
	for_each = data.azurerm_linux_web_app.web_apps
  source = "../../modules/app_service_certificate_binding"
  app_custom_domain_verification_id = each.value.custom_domain_verification_id
  app_location = each.value.location
  app_rg_name = each.value.resource_group_name
  certificate_name = var.certificate_name
  keyvault_id = data.azurerm_key_vault.certificate_keyvault.id
}