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

module "identity" {
  source                                  = "../../modules/identity"

  identity_name                           = "${var.rg_prefix}-${var.rg_name}-${var.identity_name}"
  rg_name                                 = var.rg_name
  vaultresourcegroup                      = var.vaultresourcegroup
  vaultname                               = var.vaultname
  existingkeyvaultsecretname              = var.existingkeyvaultsecretname
  certificatename                         = var.certificatename
  domain                                  = var.domain
  envurl                                  = var.envurl
  serviceplan_suffix					  = "serviceplan"
  webapp_sku_tier                         = var.webapp_sku_tier_p2
  webapp_sku_name                         = var.webapp_sku_name_p2
  identity_capacity                       = var.identity_capacity
  env_profile                             = var.env_profile
  custom_emails                           = var.custom_emails
  scaling_enabled                         = var.scaling_enabled
  app_managed_identity_id				  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_command_line				  		  = var.identity_app_command_line

}

module "identity-management" {
  source                            = "../../modules/identity-management"

  identity_management_name          = "${var.rg_prefix}-${var.rg_name}-${var.identity_management_name}"
  rg_name                           = var.rg_name
  env_profile                       = var.env_profile
  webapp_sku_tier                   = var.webapp_sku_tier_p2
  webapp_sku_name                   = var.webapp_sku_name_p1

}

module "lpg-learner-record" {
  source                          = "../../modules/lpg-learner-record"

  allowed_ip_addresses 			  = local.allowed_ips
  lpg_learner_record_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}"
  rg_name                         = var.rg_name
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  domain                          = var.domain
  envurl                          = var.envurl
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p2
  learner_record_capacity         = var.learner_record_capacity
  env_profile                     = var.env_profile
  custom_emails                   = var.custom_emails
  scaling_enabled                 = var.scaling_enabled
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_command_line     			  = var.learner_record_app_command_line

}

module "lpg-report-service" {
  source                          = "../../modules/lpg-report-service"

  lpg_report_service_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_report_service_name}"
  allowed_ip_addresses			  = local.allowed_ips
  rg_name                         = var.rg_name
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  domain                          = var.domain
  envurl                          = var.envurl
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p3
  env_profile                     = var.env_profile
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_command_line				  = var.report_service_app_command_line
}

module "lpg-ui" {
  source                          = "../../modules/lpg-ui"

  lpg_ui_name                     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_ui_name}"
  rg_name_lpg_ui                  = var.rg_name_lpg_ui
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.ui_existingkeyvaultsecretname
  certificatename 			      = var.ui_certificatename
  domain                          = var.domain
  envurl                          = var.envurl
  serviceplan_suffix_lpgui        = var.serviceplan_suffix_lpgui
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p2
  lpg_ui_capacity                 = var.lpg_ui_capacity
  env_profile                     = var.env_profile
  custom_emails                   = var.custom_emails
  scaling_enabled                 = var.scaling_enabled
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id

}

module "lpg-learning-catalogue" {
  source                          = "../../modules/lpg-learning-catalogue"

  lpg_learning_catalogue_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}"
  rg_name                         = var.rg_name
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  domain                          = var.domain
  envurl                          = var.envurl
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  learning_catalogue_capacity     = var.learning_catalogue_capacity
  env_profile                     = var.env_profile
  custom_emails                   = var.custom_emails
  scaling_enabled                 = var.scaling_enabled
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_command_line				  = var.learning_catalogue_app_command_line
}

module "civil-servant-registry-service" {
  source                          = "../../modules/civil-servant-registry-service"

  allowed_ip_addresses			  = local.allowed_ips
  civil_servant_registry_name	  = "${var.rg_prefix}-${var.rg_name}-${var.civil_servant_registry_name}"
  rg_name						  = var.rg_name
  vaultresourcegroup			  = var.vaultresourcegroup
  vaultname						  = var.vaultname
  existingkeyvaultsecretname	  = var.existingkeyvaultsecretname
  certificatename				  = var.certificatename
  domain						  = var.domain
  envurl						  = var.envurl
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  csrs_capacity                   = var.csrs_capacity
  env_profile                     = var.env_profile
  scaling_enabled				  = var.scaling_enabled
  custom_emails 				  = var.custom_emails
  app_managed_identity_id		  = data.azurerm_user_assigned_identity.app_service_identity.id
  app_command_line				  = var.civil_servant_registry_app_command_line
}

module "lpg-management" {
  source                             = "../../modules/lpg-management"

  lpg_management_name                = "${var.rg_prefix}-${var.rg_name}-${var.lpg_management_name}"
  rg_name                            = var.rg_name
  vaultresourcegroup                 = var.vaultresourcegroup
  vaultname                          = var.vaultname
  existingkeyvaultsecretname         = var.existingkeyvaultsecretname
  certificatename                    = var.certificatename
  domain                             = var.domain
  envurl                             = var.envurl
  webapp_sku_tier                    = var.webapp_sku_tier_p2
  webapp_sku_name                    = var.webapp_sku_name_p2
  lpg_management_capacity            = var.lpg_management_capacity
  env_profile                        = var.env_profile
  app_managed_identity_id			 = data.azurerm_user_assigned_identity.app_service_identity.id
}

module "notification-service" {
  source                             = "../../modules/notification-service"

  rg_name                            = var.rg_name
  notification_service_name          = "${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}"
  env_profile                        = var.env_profile
  webapp_sku_tier                    = var.webapp_sku_tier_p2
  webapp_sku_name                    = var.webapp_sku_name_p1
  notification_capacity              = var.notification_capacity
  allowed_ip_addresses 				 = local.allowed_ips
  app_managed_identity_id			 = data.azurerm_user_assigned_identity.app_service_identity.id
  app_command_line					 = var.notification_service_app_command_line
}

# CSL-SERVICE

module "csl_service" {
    source                          = "../../modules/app_service"
    rg_name                         = var.rg_name
    app_name                        = "csl-service"
    sku_name                        = var.csl_service_vertical_scale
    horizontal_scale                = var.csl_service_horizontal_scale
    app_command_line                = var.csl_service_app_command_line
    allowed_ip_addresses            = local.allowed_ips
	app_managed_identity_id         = data.azurerm_user_assigned_identity.app_service_identity.id
	healthcheck_path_override 		= "/api/manage/health"
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
  # The browser will be interacting with Rustici, so we can't filter any IP addresses here
  allowed_ip_addresses            = []
  healthcheck_path_override       = "/ping"
  app_managed_identity_id         = data.azurerm_user_assigned_identity.app_service_identity.id
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
