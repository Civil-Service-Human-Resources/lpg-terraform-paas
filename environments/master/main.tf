module "subscription" {
	source = "../../modules/subscription"
	subscription_name = var.subscription_name
}

module "redis-session" {
  source         = "../../modules/redis"
  rg_name        = var.rg_name
  rg_prefix      = var.rg_prefix
  rg_location    = var.rg_location
  redis_name     = "${var.rg_prefix}-${var.rg_name}-redis-session"
  env_profile    = var.env_profile
  redis_capacity = var.redis_session_capacity
  allowed_ips = toset(concat(
		local.lpg_ui_ips,
		local.lpg_management_ips,
		local.identity_ips
	))
}

module "redis-org" {
  source         = "../../modules/redis"
  rg_name        = var.rg_name
  rg_prefix      = var.rg_prefix
  rg_location    = var.rg_location
  redis_name     = "${var.rg_prefix}-${var.rg_name}-redis-org"
  env_profile    = var.env_profile
  redis_capacity = var.redis_org_capacity
  allowed_ips = toset(concat(
		local.lpg_ui_ips,
		local.lpg_management_ips
	))
}

module "redis-csl-service" {
  source         = "../../modules/redis"
  rg_name        = var.rg_name
  rg_prefix      = var.rg_prefix
  rg_location    = var.rg_location
  redis_name     = "${var.rg_prefix}-${var.rg_name}-redis-csl-service"
  env_profile    = var.env_profile
  redis_capacity = var.redis_csl_service_capacity
  allowed_ips = toset(concat(
		module.csl_service.ip_addresses
	))
}

module "mysql_gp" {
  source            = "../../modules/mysql_generalpurpose"
  rg_name           = var.rg_name
  rg_prefix         = var.rg_name
  rg_location       = var.rg_location
  mysql_name        = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}"
  env_profile       = var.env_profile
}

#module "blob" {
#  source               = "../../modules/blob"
#  rg_name              = var.rg_name
#  rg_prefix            = var.rg_prefix
#  rg_location          = var.rg_location
#  storage_account_name = "${var.rg_prefix}${var.rg_name}blob"
#  env_profile          = var.env_profile
#}

# DevOps

data "azurerm_user_assigned_identity" "app_service_identity" {
  resource_group_name = "rg-devops-${var.env_profile}"
  name = "uai-${var.env_profile}"
}

data "azurerm_dns_zone" "dns_zone" {
  name = var.domain
  resource_group_name = "lpgdomain"
}

# Apps

## Frontend

module "lpg-ui" {
  source = "../../modules/app_service"

  app_command_line = "npm run start:ui"
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "lpg-ui"
  rg_name = var.rg_name
  horizontal_scale = var.lpg_ui_horizontal_scale
  sku_name = var.lpg_ui_vertical_scale
  use_legacy_name = true
  healthcheck_path_override = ""
  serviceplan_suffix = var.serviceplan_suffix_lpgui
}

module "lpg-management" {
  source = "../../modules/app_service"

  app_command_line = "npm start"
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "lpg-management"
  rg_name = var.rg_name
  horizontal_scale = var.lpg_management_horizontal_scale
  sku_name = var.lpg_management_vertical_scale
  use_legacy_name = true
  healthcheck_path_override = ""
}

## Backend

module "identity" {
  source = "../../modules/app_service"

  app_command_line = var.identity_app_command_line
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "identity"
  rg_name = var.rg_name
  horizontal_scale = var.identity_horizontal_scale
  sku_name = var.identity_vertical_scale
  use_legacy_name = true
}

module "identity-management" {
  source = "../../modules/app_service"

  app_command_line = ""
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "identity-management"
  rg_name = var.rg_name
  horizontal_scale = var.identity_management_horizontal_scale
  sku_name = var.identity_management_vertical_scale
  use_legacy_name = true
  healthcheck_path_override = ""
}

module "lpg-learner-record" {
  source = "../../modules/app_service"

  app_command_line = var.learner_record_app_command_line
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "lpg-learner-record"
  rg_name = var.rg_name
  horizontal_scale = var.learner_record_horizontal_scale
  sku_name = var.learner_record_vertical_scale
  use_legacy_name = true
  allowed_ip_addresses = local.allowed_ips
}

module "lpg-report-service" {
  source = "../../modules/app_service"

  app_command_line = var.report_service_app_command_line
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "lpg-report-service"
  rg_name = var.rg_name
  horizontal_scale = var.report_service_horizontal_scale
  sku_name = var.report_service_vertical_scale
  use_legacy_name = true
  allowed_ip_addresses = local.allowed_ips
}

module "lpg-learning-catalogue" {
  source = "../../modules/app_service"

  app_command_line = var.learning_catalogue_app_command_line
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "lpg-learning-catalogue"
  rg_name = var.rg_name
  horizontal_scale = var.learning_catalogue_horizontal_scale
  sku_name = var.learning_catalogue_vertical_scale
  use_legacy_name = true
}

module "civil-servant-registry-service" {
  source = "../../modules/app_service"

  app_command_line = var.civil_servant_registry_app_command_line
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "civil-servant-registry"
  rg_name = var.rg_name
  horizontal_scale = var.civil_servant_registry_horizontal_scale
  sku_name = var.civil_servant_registry_vertical_scale
  use_legacy_name = true
  allowed_ip_addresses = local.allowed_ips
}

module "notification-service" {
  source = "../../modules/app_service"

  app_command_line = var.notification_service_app_command_line
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_name = "notification-service"
  rg_name = var.rg_name
  horizontal_scale = var.notification_service_horizontal_scale
  sku_name = var.notification_service_vertical_scale
  use_legacy_name = true
  allowed_ip_addresses = local.allowed_ips
}

# CSL-SERVICE

module "csl_service" {
  source                          = "../../modules/app_service"
  rg_name                         = var.rg_name
  app_name                        = "csl-service"
  sku_name                        = var.csl_service_vertical_scale
  horizontal_scale                = var.csl_service_horizontal_scale
  app_command_line                = var.csl_service_app_command_line
  app_managed_identity_id         = data.azurerm_user_assigned_identity.app_service_identity.id
  healthcheck_path_override 		= "/api/manage/health"
  frontdoor_enabled = true
}

module "csl_service_frontdoor" {
  source = "../../modules/frontdoor/app_service_single_frontdoor_domain"

  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
  dns_zone_id = data.azurerm_dns_zone.dns_zone.id
  app_subdomain = "csl-service"
  app_service_hostname = module.csl_service.default_hostname
  env_profile = var.env_profile
  domain = var.domain
  dns_zone_resource_group = "lpgdomain"
}

# RUSTICI

module "rustici_engine" {
  source                          = "../../modules/app_service"
  rg_name                         = var.rg_name
  app_name                        = "rustici-engine"
  sku_name                        = var.rustici_engine_vertical_scale
  horizontal_scale                = var.rustici_engine_horizontal_scale
  app_command_line                = "./installScript.sh"
  healthcheck_path_override       = "/ping"
  app_managed_identity_id         = data.azurerm_user_assigned_identity.app_service_identity.id
  frontdoor_enabled = true
}

module "rustici_frontdoor" {
	source = "../../modules/frontdoor/rustici_frontdoor_domain"

	cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor_profile.id
	dns_zone_id = data.azurerm_dns_zone.dns_zone.id
	rustici_engine_hostname = module.rustici_engine.default_hostname
	blob_storage_fqdn = "${var.content_container}.azureedge.net"
	env_profile = var.env_profile
	domain = var.domain
	dns_zone_resource_group = "lpgdomain"
}

module "rustici_mysql" {
	source = "../../modules/mysql_flexible"
	name = "fl-mysql-${var.rg_name}-rustici"
	location = var.rg_location
	rg_name = var.rg_name
	size_in_gb = var.rustici_mysql_size_gb
	sku = var.rustici_mysql_sku
	databases = [ "RusticiEngineDB" ]
}

# App frontdoor

resource "azurerm_cdn_frontdoor_profile" "frontdoor_profile" {
  name                = "fd-apps-${var.env_profile}"
  resource_group_name = var.rg_name
  sku_name            = "Premium_AzureFrontDoor"
}
