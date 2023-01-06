data "azurerm_resource_group" "app_service_rg" {
  name = var.rg_name
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "sp-${data.azurerm_resource_group.app_service_rg.name}-${var.app_name}"
  location            = data.azurerm_resource_group.app_service_rg.location
  resource_group_name = data.azurerm_resource_group.app_service_rg.name
  os_type             = "Linux"
  sku_name            = var.sku_name
  worker_count        = var.horizontal_scale
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "${data.azurerm_resource_group.app_service_rg.name}-${var.app_name}"
  resource_group_name = data.azurerm_resource_group.app_service_rg.name
  location            = azurerm_service_plan.app_service_plan.location
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    app_command_line = var.app_command_line
    ip_restriction = [for ip in var.allowed_ip_addresses : {
      ip_address = "${ip}/32"
      action     = "Allow"
      priority   = 1
      name       = "app service"
      headers = [{
        x_azure_fdid      = null
        x_fd_health_probe = null
        x_forwarded_for   = null
        x_forwarded_host  = null
      }]
      service_tag               = null
      virtual_network_subnet_id = null
    }]
    minimum_tls_version = "1.2"
    http2_enabled       = false

    application_stack {
      docker_image     = var.docker_image
      docker_image_tag = var.docker_tag
    }

    health_check_path = "/health"
    auto_heal_enabled = true
    auto_heal_setting {
      action {
        action_type = "Recycle"
      }
      trigger {
		status_code {
		  status_code_range = "502"
		  count = 10
		  interval = "00:00:60"
		}
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  logs {
    application_logs {
      file_system_level = "Information"
    }
  }

}

# Host

resource "azurerm_app_service_custom_hostname_binding" "custom_hostname" {
  hostname            = var.domain
  app_service_name    = azurerm_linux_web_app.app_service.name
  resource_group_name = azurerm_linux_web_app.app_service.resource_group_name

  # Ignore ssl_state and thumbprint as they are managed using
  # azurerm_app_service_certificate_binding.example
  lifecycle {
    ignore_changes = [ssl_state, thumbprint]
  }
}

# Certificate Keyvault

data "azurerm_key_vault" "certificate_kv" {
  resource_group_name = var.certificate_keyvault_name_rg
  name = var.certificate_keyvault_name
}

resource "azurerm_key_vault_access_policy" "certificate_kv_access" {
  key_vault_id = data.azurerm_key_vault.certificate_kv.id
  tenant_id = azurerm_linux_web_app.app_service.identity.0.tenant_id
  object_id = azurerm_linux_web_app.app_service.identity.0.principal_id

  certificate_permissions = [ "Get" ]
  secret_permissions = [ "Get" ]
}

# Secret Keyvault

# data "azurerm_key_vault" "secret_kv" {
# 	resource_group_name = var.secret_keyvault_name_rg
#   	name = var.secret_keyvault_name
# }

# resource "azurerm_key_vault_access_policy" "secret_kv_access" {
#   key_vault_id = data.azurerm_key_vault.secret_kv.id
#   tenant_id = azurerm_linux_web_app.app_service.identity.0.tenant_id
#   object_id = azurerm_linux_web_app.app_service.identity.0.principal_id

#   secret_permissions = [ "Get" ]
# }

# Certificate

data "azurerm_key_vault_certificate" "app_keyvault_cert" {
  name         = var.certificate_name
  key_vault_id = data.azurerm_key_vault.certificate_kv.id

  depends_on = [
	azurerm_key_vault_access_policy.certificate_kv_access
  ]
}

resource "azurerm_app_service_certificate" "identity_service_certificate" {
  name                = var.certificate_name
  resource_group_name = azurerm_linux_web_app.app_service.resource_group_name
  location            = azurerm_linux_web_app.app_service.location
  key_vault_secret_id = data.azurerm_key_vault_certificate.app_keyvault_cert.secret_id
}

resource "azurerm_app_service_certificate_binding" "identity_service_cert_binding" {
  hostname_binding_id = azurerm_linux_web_app.app_service.custom_domain_verification_id
  certificate_id      = azurerm_app_service_certificate.identity_service_certificate.id
  ssl_state           = "SniEnabled"
}