module "app_service" {
  source = "../app_service"
  rg_name                         = var.rg_name
  app_name                        = "rustici-engine"
  sku_name                        = var.vertical_scale
  horizontal_scale                = var.horizontal_scale
  app_command_line                = "./installScript.sh"
  # The browser will be interacting with Rustici, so we can't filter any IP addresses here
  allowed_ip_addresses            = []
  healthcheck_path_override = "/ping"
}

data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

# Gateway

# User assigned identity - should be managed in a
# separate state and referred to here (and every other app service) 
# via data block.
resource "azurerm_user_assigned_identity" "managed_identity" {
  location            = data.azurerm_resource_group.rg.location 
  name                = "rustici-${var.env_profile}"
  resource_group_name = data.azurerm_resource_group.rg.name 
}

data "azurerm_key_vault" "kv" {
  name = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

data "azurerm_key_vault_certificate" "cert" {
  key_vault_id = data.azurerm_key_vault.kv.id
  name = var.cert_name
}

resource "azurerm_key_vault_access_policy" "kv_access" {
  key_vault_id = data.azurerm_key_vault.kv.id
  tenant_id = azurerm_user_assigned_identity.managed_identity.tenant_id
  object_id = azurerm_user_assigned_identity.managed_identity.client_id

  secret_permissions = [
	"Get",
  ]

  certificate_permissions = [
	"Get",
	"Import"
  ]
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "vnet-rustici-${var.env_profile}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "ip-rustici-${var.env_profile}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku 				  = "Standard"
}

locals {
  backend_address_pool_name      = "${azurerm_virtual_network.virtual_network.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.virtual_network.name}-feport"
  frontend_ip_configuration_name = "appGwPublicFrontendIpIPv4"
  listener_name                  = "${azurerm_virtual_network.virtual_network.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.virtual_network.name}-rqrt"
  rustici_be_settings_name       = "rustici-be-settings"
  cdn_be_settings_name           = "cdn-setting"
  path_map_name      			 = "rustici-engine-path-map"
  probe_name                     = "rustici-engine"
  cert_name						 = "cert"
}

# App gateway

resource "azurerm_application_gateway" "gateway" {
  name                = "ap-rustici-${var.env_profile}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  identity {
	type = "UserAssigned" 
	identity_ids = [ azurerm_user_assigned_identity.managed_identity.id ]
  }

  ssl_certificate {
	name = local.cert_name
	key_vault_secret_id = data.azurerm_key_vault_certificate.cert.secret_id
  }

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = var.gateway_capacity
  }

  gateway_ip_configuration {
    name      = "ag-ip-configuration"
    subnet_id = azurerm_subnet.subnet.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  # App service

  backend_address_pool {
    name = module.app_service.default_hostname
	fqdns = [module.app_service.default_hostname]
  }

  backend_http_settings {
    name                  = local.rustici_be_settings_name
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
	pick_host_name_from_backend_address = true
	probe_name = local.probe_name
  }

  # Content CDN

  backend_address_pool {
    name = var.content_cdn_fqdn
	fqdns = [var.content_cdn_fqdn]
  }

  backend_http_settings {
    name                  = local.cdn_be_settings_name
    cookie_based_affinity = "Disabled"
	path                  = "/e-learning"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
	pick_host_name_from_backend_address = true
	probe_name = "rustici-engine"
  }

  # General rules

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
	host_name 					   = "rustici-engine.${var.domain}"
	require_sni                    = true
	ssl_certificate_name 		   = local.cert_name
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
	priority                   = 1
    rule_type                  = "PathBasedRouting"
    http_listener_name         = local.listener_name
	url_path_map_name          = local.path_map_name
  }

  url_path_map {
	name = local.path_map_name
	default_backend_address_pool_name = module.app_service.default_hostname
	default_backend_http_settings_name = local.rustici_be_settings_name
	path_rule {
	  name = "cdn"
	  paths = [ "/cdn*" ]
	  backend_address_pool_name = var.content_cdn_fqdn
	  backend_http_settings_name = local.cdn_be_settings_name
	}
  }

  probe {
    interval                                  = 30
    minimum_servers                           = 0
    name                                      = local.probe_name
    path                                      = "/"
    pick_host_name_from_backend_http_settings = true
    protocol                                  = "Https"
    timeout                                   = 30
    unhealthy_threshold                       = 3

    match {
      status_code = [
			"200-500"
		]
    }

  }
}

# DNS A record

resource "azurerm_dns_a_record" "a_record" {
  for_each = toset(var.env_profile != "prod" ? [var.domain] : [])
  name = "rustici-engine"
  zone_name = each.value
  resource_group_name = "lpgdomain"
  ttl = 3600
  records = [ azurerm_public_ip.pip.ip_address ]
}