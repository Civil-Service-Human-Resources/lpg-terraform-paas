data "azurerm_resource_group" "app_service_rg" {
  name = var.rg_name
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = var.use_legacy_name == true ? "lpg-${data.azurerm_resource_group.app_service_rg.name}-${var.app_name}serviceplan${var.serviceplan_suffix}" : "sp-${data.azurerm_resource_group.app_service_rg.name}-${var.app_name}"
  location            = data.azurerm_resource_group.app_service_rg.location
  resource_group_name = data.azurerm_resource_group.app_service_rg.name
  os_type             = "Linux"
  sku_name            = var.sku_name
  worker_count        = var.horizontal_scale
}

resource "azurerm_linux_web_app" "app_service" {
  name                = var.use_legacy_name == true ? "lpg-${data.azurerm_resource_group.app_service_rg.name}-${var.app_name}" : "${data.azurerm_resource_group.app_service_rg.name}-${var.app_name}"
  resource_group_name = data.azurerm_resource_group.app_service_rg.name
  location            = azurerm_service_plan.app_service_plan.location
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  https_only = true
  client_affinity_enabled = true
  site_config {
    app_command_line = var.app_command_line
    dynamic ip_restriction {
      for_each = var.frontdoor_enabled == true ? [1] : []
      content {
        action     				= "Allow"
        ip_address				= null
        priority   				= 1
        name       				= "Front door"
        headers 					= []
        service_tag               = "AzureFrontDoor.Backend"
        virtual_network_subnet_id = null
      }
    }
    dynamic ip_restriction {
      for_each = [for ip in var.allowed_ip_addresses : {
        ip_address = "${ip}/32"
        action     = "Allow"
        priority   = 1
        name       = "app service"
        headers = []
        service_tag               = null
        virtual_network_subnet_id = null
      }]
      iterator = item
      content {
        ip_address = item.value.ip_address
        action     = item.value.action
        priority   = item.value.priority
        name       = item.value.name
        headers = item.value.headers
        service_tag               = item.value.service_tag
        virtual_network_subnet_id = item.value.virtual_network_subnet_id
      }
    }
    minimum_tls_version = "1.2"
    http2_enabled       = false

    health_check_path = var.healthcheck_path_override
  }

  identity {
	type = "SystemAssigned, UserAssigned"
	identity_ids = [ var.app_managed_identity_id ]
  }

  key_vault_reference_identity_id = var.app_managed_identity_id

  logs {
    detailed_error_messages = true
    application_logs {
      file_system_level = "Information"
    }
	http_logs {
	  file_system {
		retention_in_days = 0
		retention_in_mb = 35
	  }

	}
  }

  lifecycle {
	ignore_changes = [
	  app_settings
	]
  }

}

# Outputs

output "verification_id" {
  value = azurerm_linux_web_app.app_service.custom_domain_verification_id
}

output "default_hostname" {
	value = azurerm_linux_web_app.app_service.default_hostname
}

output "ip_addresses" {
	value = azurerm_linux_web_app.app_service.possible_outbound_ip_address_list
}
