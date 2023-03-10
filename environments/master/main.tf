module "subscription" {
	source = "../../modules/subscription"
	subscription_name = var.subscription_name
}

module "redis" {
  source         = "../../modules/redis"
  rg_name        = var.rg_name
  rg_prefix      = var.rg_prefix
  rg_location    = var.rg_location
  redis_name     = "${var.rg_prefix}-${var.rg_name}-redis"
  env_profile    = var.env_profile
  redis_capacity = var.redis_capacity
}


module "redis-session" {
  source         = "../../modules/redis"
  rg_name        = var.rg_name
  rg_prefix      = var.rg_prefix
  rg_location    = var.rg_location
  redis_name     = "${var.rg_prefix}-${var.rg_name}-redis-session"
  env_profile    = var.env_profile
  redis_capacity = var.redis_session_capacity
}

module "redis-org" {
  source         = "../../modules/redis"
  rg_name        = var.rg_name
  rg_prefix      = var.rg_prefix
  rg_location    = var.rg_location
  redis_name     = "${var.rg_prefix}-${var.rg_name}-redis-org"
  env_profile    = var.env_profile
  redis_capacity = var.redis_org_capacity
}

module "mysql_gp" {
  source            = "../../modules/mysql_generalpurpose"
  rg_name           = var.rg_name
  rg_prefix         = var.rg_name
  rg_location       = var.rg_location
  mysql_name        = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}"
  env_profile       = var.env_profile
}

module "mysql_ll" {
  source            = "../../modules/mysql_generalpurpose"
  rg_name           = var.rg_name
  rg_prefix         = var.rg_name
  rg_location       = var.rg_location
  mysql_name        = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name_ll}"
  mysql_storage     = var.mysql_storage
  env_profile       = var.env_profile
}

module "cosmos" {
  source      = "../../modules/cosmos"
  rg_name     = var.rg_name
  rg_prefix   = var.rg_name
  rg_location = var.rg_location
  cosmos_name = "${var.rg_prefix}-${var.rg_name}-${var.cosmos_name}"
  env_profile = var.env_profile
}

#module "blob" {
#  source               = "../../modules/blob"
#  rg_name              = var.rg_name
#  rg_prefix            = var.rg_prefix
#  rg_location          = var.rg_location
#  storage_account_name = "${var.rg_prefix}${var.rg_name}blob"
#  env_profile          = var.env_profile
#}

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
  learner_record_command_line     = var.learner_record_command_line
  custom_emails                   = var.custom_emails
  scaling_enabled                 = var.scaling_enabled

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
  report_service_command_line     = var.report_service_command_line

}

module "lpg-learning-locker-xapi" {
  source                          = "../../modules/learning-locker-xapi"
  
  learning_locker_xapi_name       = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}"
  rg_name                         = var.rg_name
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  domain                          = var.domain
  envurl                          = var.envurl
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  xapi_capacity                   = var.xapi_capacity
  env_profile                     = var.env_profile
  custom_emails                   = var.custom_emails
  scaling_enabled                 = var.scaling_enabled
  
}

module "lpg-learning-locker-worker" {
  source                          = "../../modules/learning-locker-worker"
  
  learning_locker_worker_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_worker_name}"
  rg_name                         = var.rg_name
  env_profile                     = var.env_profile
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1

}

module "lpg-learning-locker-ui" {
  source                          = "../../modules/learning-locker-ui"
  
  learning_locker_ui_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}"
  rg_name                         = var.rg_name
  env_profile                     = var.env_profile
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1

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
}

module "notification-service" {
  source                             = "../../modules/notification-service"

  rg_name                            = var.rg_name
  notification_service_name          = "${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}"
  env_profile                        = var.env_profile
  webapp_sku_tier                    = var.webapp_sku_tier_p2
  webapp_sku_name                    = var.webapp_sku_name_p1
  notification_capacity              = var.notification_capacity
  allowed_ip_addresses 				= local.allowed_ips
}

module "overview-dashboard" {
  source                      = "../../modules/dashboards"
  overview_dashboard_name     = "CSL ${title(var.env_profile)} Service Overview"
  rg_name                     = var.rg_name
  rg_prefix                   = var.rg_prefix
  rg_location                 = var.rg_location
  env_profile                 = var.env_profile
  civil_servant_registry_name = "${var.rg_prefix}-${var.rg_name}-${var.civil_servant_registry_name}"
  identity_management_name    = "${var.rg_prefix}-${var.rg_name}-${var.identity_management_name}"
  identity_name               = "${var.rg_prefix}-${var.rg_name}-${var.identity_name}"
  learning_locker_worker_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_worker_name}"
  learning_locker_ui_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}"
  learning_locker_xapi_name   = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}"
  lpg_learner_record_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}"
  lpg_learning_catalogue_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}"
  lpg_management_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_management_name}"
  lpg_report_service_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_report_service_name}"
  lpg_ui_name                 = "${var.rg_prefix}-${var.rg_name}-${var.lpg_ui_name}"
  notification_service_name   = "${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}"
  redis_name                  = "${var.rg_prefix}-${var.rg_name}-redis"
  redis_name_session          = "${var.rg_prefix}-${var.rg_name}-redis-session"
  mysql_name                  = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}"
  cosmos_name                 = "${var.rg_prefix}-${var.rg_name}-${var.cosmos_name}"
}

module "data-transchiver" {
  source                           = "../../modules/data-transchiver"

  data_transchiver_name			   = "${var.rg_prefix}-${var.rg_name}-${var.data_transchiver_name}"
  rg_name                          = var.rg_name
  env_profile                      = var.env_profile
  webapp_sku_tier                  = var.webapp_sku_tier_p2
  webapp_sku_name                  = var.webapp_sku_name_p1
}

# CSL-SERVICE

module "csl_service" {
    source                          = "../../modules/app_service"
    rg_name                         = var.rg_name
    app_name                        = "csl-service"
    sku_name                        = var.csl_service_vertical_scale
    horizontal_scale                = var.csl_service_horizontal_scale
    app_command_line                = "java -javaagent:/opt/appinsights/applicationinsights-agent-3.4.4.jar -jar /data/app.jar"
    allowed_ip_addresses            = local.allowed_ips
}

# RUSTICI

module "rustici_engine" {
    source                          = "../../modules/rustici_engine"
    rg_name                         = var.rg_name
    horizontal_scale                = var.rustici_engine_horizontal_scale
	vertical_scale                  = var.rustici_engine_vertical_scale
	gateway_capacity                = 1
	content_cdn_fqdn                = "${var.content_container}.azureedge.net"
	env_profile                     = var.env_profile
	domain                          = var.domain
	cert_name 						= var.certificatename
	key_vault_name 					= var.vaultname
	key_vault_rg_name				= var.vaultresourcegroup
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

module "keyvault" {
  source = "../../modules/keyvault"
  rg_name = var.rg_name
  rg_name_lpg_ui = var.rg_name_lpg_ui
  name = "kv-${var.rg_name}-vars"
  location = var.rg_location
  keyvault_users_group_object_id = var.keyvault_users_group_object_id
}
