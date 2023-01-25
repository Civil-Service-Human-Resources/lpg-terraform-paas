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
  mysql_admin_login = var.mysql_user
  mysql_admin_pass  = var.mysql_pass
  env_profile       = var.env_profile
}

module "mysql_ll" {
  source            = "../../modules/mysql_generalpurpose"
  rg_name           = var.rg_name
  rg_prefix         = var.rg_name
  rg_location       = var.rg_location
  mysql_name        = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name_ll}"
  mysql_admin_login = var.mysql_user
  mysql_admin_pass  = var.mysql_pass_ll
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
  rg_name                                 = var.rg_name
  rg_prefix                               = var.rg_prefix
  rg_location                             = var.rg_location
  identity_name                           = "${var.rg_prefix}-${var.rg_name}-${var.identity_name}"
  domain                                  = var.domain
  datasource                              = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/identity?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  docker_tag                              = var.identity_docker_tag
  docker_repository_region                = var.identity_docker_repository_region
  env_profile                             = var.env_profile
  vaultresourcegroup                      = var.vaultresourcegroup
  vaultname                               = var.vaultname
  existingkeyvaultsecretname              = var.existingkeyvaultsecretname
  certificatename                         = var.certificatename
  envurl                                  = var.envurl
  invite_signup_url                       = "https://identity.${var.domain}/signup/%s"
  reset_url                               = "https://identity.${var.domain}/reset/%s"
  lpg_ui_url                              = "https://${var.domain}"
  redis_host                              = module.redis-session.redis_host
  redis_password                          = module.redis-session.redis_key
  redis_port                              = "6379"
  scaling_enabled                         = var.scaling_enabled
  custom_emails                           = var.custom_emails
  webapp_sku_tier                         = var.webapp_sku_tier_p2
  webapp_sku_name                         = var.webapp_sku_name_p2
  identity_capacity                       = var.identity_capacity
  docker_registry_server_url              = var.docker_registry_server_url


  authentication_service_url              = "https://identity.${var.domain}"
  registry_service_url                    = "https://civil-servant-registry.${var.domain}"

  invite_validity                         = var.invite_validity
  duration_after_rereg_allowed_seconds    = var.duration_after_rereg_allowed_seconds
  maintenance_page_enabled                = var.maintenance_page_enabled
  maintenance_page_content_line_1         = var.maintenance_page_content_line_1
  maintenance_page_content_line_2         = var.maintenance_page_content_line_2
  maintenance_page_content_line_3         = var.maintenance_page_content_line_3
  maintenance_page_content_line_4         = var.maintenance_page_content_line_4

  identity_base_url = var.identity_base_url
}

module "identity-management" {
  source                            = "../../modules/identity-management"
  rg_name                           = var.rg_name
  rg_prefix                         = var.rg_prefix
  rg_location                       = var.rg_location
  identity_management_name          = "${var.rg_prefix}-${var.rg_name}-${var.identity_management_name}"
  docker_tag                        = var.identity_management_docker_tag
  docker_repository_region          = var.identity_management_docker_repository_region
  env_profile                       = var.env_profile
  datasource                        = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/identity?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  authentication_service_url        = "https://identity.${var.domain}"
  learner_record_url                = "https://learning-record.${var.domain}"
  registry_service_url              = "https://civil-servant-registry.${var.domain}"
  notification_service_url          = "https://${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}.azurewebsites.net"
  identity_management_url           = "https://${var.rg_prefix}-${var.rg_name}-identity-management.azurewebsites.net"
  vaultresourcegroup                = var.vaultresourcegroup
  vaultname                         = var.vaultname
  existingkeyvaultsecretname        = var.existingkeyvaultsecretname
  certificatename                   = var.certificatename
  envurl                            = var.envurl
  webapp_sku_tier                   = var.webapp_sku_tier_p2
  webapp_sku_name                   = var.webapp_sku_name_p1
  docker_registry_server_url        = var.docker_registry_server_url



  data_retention_cron_schedule      = var.identity_management_data_retention_cron_schedule
  data_retention_enabled            = var.identity_management_data_retention_enabled

}

module "lpg-learner-record" {
  source                          = "../../modules/lpg-learner-record"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  lpg_learner_record_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}"
  domain                          = var.domain
  docker_tag                      = var.lpg_learner_record_docker_tag
  docker_repository_region        = var.lpg_learner_record_docker_repository_region
  env_profile                     = var.env_profile
  websites_port                   = var.lpg_learner_record_websites_port
  course_catalogue_url            = "https://learning-resources.${var.domain}"
  registry_service_url            = "https://civil-servant-registry.${var.domain}"
  authentication_service_url      = "https://identity.${var.domain}"
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  spring_profiles_active          = var.spring_profiles_active
  datasource                      = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/learner_record?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  lpg_ui_url                      = "https://${var.domain}"
  notification_service_url        = "https://${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}.azurewebsites.net"
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p2
  learner_record_capacity         = var.learner_record_capacity
  docker_registry_server_url      = var.docker_registry_server_url


  learner_record_command_line     = var.learner_record_command_line


  # LPG-UI, management, catalogue, report
  allowed_ip_addresses = local.allowed_ips
}

module "lpg-report-service" {
  source                          = "../../modules/lpg-report-service"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  lpg_report_service_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_report_service_name}"
  domain                          = var.domain
  docker_tag                      = var.lpg_report_service_docker_tag
  docker_repository_region        = var.lpg_report_service_docker_repository_region
  env_profile                     = var.env_profile
  websites_port                   = var.report_service_websites_port
  learner_record_url              = "https://learning-record.${var.domain}"
  authentication_service_url      = "https://identity.${var.domain}"
  course_catalogue_url            = "https://learning-resources.${var.domain}"
  registry_service_url            = "https://civil-servant-registry.${var.domain}"
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p3
  docker_registry_server_url      = var.docker_registry_server_url


  report_service_command_line     = var.report_service_command_line
  datasource                      = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/learner_record?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"

  backend_api_call_batch_size     = var.backend_api_call_batch_size

  allowed_ip_addresses = local.allowed_ips
}

module "lpg-learning-locker-xapi" {
  source                          = "../../modules/learning-locker-xapi"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  learning_locker_xapi_name       = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}"
  domain                          = var.domain
  mongo_url                       = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false&appName=@${module.cosmos.cosmos_name}@"
  redis_url                       = "redis://${module.redis.redis_host}:${module.redis.redis_port}/0?password=${module.redis.redis_key}"
  docker_tag                      = var.ll_docker_tag
  env_profile                     = var.env_profile
  redis_use_tls                   = var.redis_use_tls
  websites_port                   = var.ll_xapi_express_port
  redis_prefix                    = var.redis_prefix
  express_port                    = var.ll_xapi_express_port
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  xapi_capacity                   = var.xapi_capacity
  docker_registry_server_url      = var.docker_registry_server_url


}

module "lpg-learning-locker-worker" {
  source                          = "../../modules/learning-locker-worker"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  learning_locker_worker_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_worker_name}"
  mongodb_path                    = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false"
  redis_host                      = module.redis.redis_host
  docker_tag                      = var.ll_docker_tag
  redis_port                      = module.redis.redis_port
  redis_password                  = module.redis.redis_key
  redis_db                        = "0"
  redis_prefix                    = var.redis_prefix
  env_profile                     = var.env_profile
  redis_use_tls                   = var.redis_use_tls
  queue_provider                  = var.redis_queue_provider
  queue_namespace                 = var.redis_queue_namespace
  testing                         = var.lpg_testing
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  docker_registry_server_url      = var.docker_registry_server_url


}

module "lpg-learning-locker-ui" {
  source                          = "../../modules/learning-locker-ui"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  mongodb_path                    = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false"
  docker_tag                      = var.ll_docker_tag
  learning_locker_ui_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}"
  api_host                        = "localhost"
  api_port                        = var.lpg_learning_locker_api_port
  env_profile                     = var.env_profile
  ui_host                         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}.azurewebsites.net"
  ui_port                         = var.ll_ui_port
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  docker_registry_server_url      = var.docker_registry_server_url


}

module "lpg-ui" {
  source                          = "../../modules/lpg-ui"
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  rg_name_lpg_ui                  = var.rg_name_lpg_ui
  serviceplan_suffix_lpgui        = var.serviceplan_suffix_lpgui
  lpg_ui_name                     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_ui_name}"
  domain                          = var.domain
  xapi_url                        = "https://xapi.${var.domain}/data/xAPI"
  authentication_service_url      = "https://identity.${var.domain}"
  docker_repository_region        = var.lpg_services_docker_repository_region
  docker_tag                      = var.lpg_services_tag
  course_catalogue_url            = "https://learning-resources.${var.domain}"
  learner_record_url              = "https://learning-record.${var.domain}"
  env_profile                     = var.env_profile
  google_analytics_id             = var.google_analytics_id
  websites_port                   = var.ui_websites_port
  content_url                     = "https://cdn.${var.domain}/${var.content_container}"
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.ui_existingkeyvaultsecretname
  envurl                          = var.envurl
  registry_service_url            = "https://civil-servant-registry.${var.domain}"
  lpg_ui_server                   = "https://${var.domain}"
  lpg_management_server           = "https://management.${var.domain}"
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p2
  lpg_ui_capacity                 = var.lpg_ui_capacity
  docker_registry_server_url      = var.docker_registry_server_url


  redis_host                      = module.redis-session.redis_host
  redis_password                  = module.redis-session.redis_key
  redis_port                      = "6379"
  org_redis_host                  = module.redis-org.redis_host
  org_redis_password              = module.redis-org.redis_key
  org_redis_port                  = "6379"
  org_redis_ttl                   = "604800"
  ui_server_timeout_ms            = var.ui_server_timeout_ms
  ui_static_asset_root            = var.ui_static_asset_root
  ui_static_asset_ttl             = var.ui_static_asset_ttl

}

module "lpg-learning-catalogue" {
  source                          = "../../modules/lpg-learning-catalogue"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  lpg_learning_catalogue_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}"
  domain                          = var.domain
  docker_tag                      = var.learning_catalogue_docker_tag
  docker_repository_region        = var.learning_catalogue_docker_repository_region
  env_profile                     = var.env_profile
  elasticsearch_protocol          = "https"
  elasticsearch_port              = 443
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  azure_account_name              = var.azure_account_name
  azure_storage_container         = var.content_container
  oauth_service_url               = "https://identity.${var.domain}"
  learner_record_url              = "https://learning-record.${var.domain}"
  registry_service_url            = "https://civil-servant-registry.${var.domain}"
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  learning_catalogue_capacity     = var.learning_catalogue_capacity
  docker_registry_server_url      = var.docker_registry_server_url




}

module "civil-servant-registry-service" {
  source                          = "../../modules/civil-servant-registry-service"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  civil_servant_registry_name     = "${var.rg_prefix}-${var.rg_name}-${var.civil_servant_registry_name}"
  domain                          = var.domain
  env_profile                     = var.env_profile
  docker_tag                      = var.civil_servant_registry_docker_tag
  docker_repository_region        = var.civil_servant_registry_docker_repository_region
  check_token_url                 = "https://identity.${var.domain}/oauth/check_token"
  datasource                      = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/csrs?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  authentication_service_url      = "https://identity.${var.domain}"
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  csrs_capacity                   = var.csrs_capacity
  docker_registry_server_url      = var.docker_registry_server_url


  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  agency_token_max_capacity       = var.agency_token_max_capacity
  agency_token_min_capacity       = var.agency_token_min_capacity


  allowed_ip_addresses = local.allowed_ips
}

module "lpg-management" {
  source                             = "../../modules/lpg-management"
  rg_name                            = var.rg_name
  rg_prefix                          = var.rg_prefix
  rg_location                        = var.rg_location
  docker_tag                         = var.lpg_management_tag
  docker_repository_region           = var.lpg_management_docker_repository_region
  lpg_management_name                = "${var.rg_prefix}-${var.rg_name}-${var.lpg_management_name}"
  domain                             = var.domain
  request_timeout_ms                 = var.lpg_management_request_timeout_ms
  server_timeout_ms                  = var.lpg_management_server_timeout_ms
  authentication_service_url         = "https://identity.${var.domain}"
  authentication_service_timeout_ms  = var.lpg_management_authentication_service_timeout_ms
  env_profile                        = var.env_profile
  websites_port                      = var.lpg_management_websites_port
  vaultresourcegroup                 = var.vaultresourcegroup
  vaultname                          = var.vaultname
  existingkeyvaultsecretname         = var.existingkeyvaultsecretname
  certificatename                    = var.certificatename
  envurl                             = var.envurl
  callback_url                       = "https://management.${var.domain}"
  lpg_ui_url                         = "https://${var.domain}"
  report_service_url                 = "https://report.${var.domain}"
  report_service_timeout_ms          = var.lpg_management_report_service_timeout_ms
  course_catalogue_url               = "https://learning-resources.${var.domain}"
  content_url                        = "https://cdn.${var.domain}/${var.content_container}"
  course_catalogue_timeout_ms        = var.lpg_management_course_catalogue_timeout_ms
  youtube_timeout_ms                 = var.lpg_management_youtube_timeout_ms
  docker_registry_server_url         = var.docker_registry_server_url


  webapp_sku_tier                    = var.webapp_sku_tier_p2
  webapp_sku_name                    = var.webapp_sku_name_p2
  lpg_management_capacity            = var.lpg_management_capacity
  registry_service_url               = "https://civil-servant-registry.${var.domain}"
  registry_service_timeout_ms        = var.lpg_management_civil_servant_registry_service_timeout_ms
  learner_record_url                 = "https://learning-record.${var.domain}"
  learner_record_timeout_ms          = var.lpg_management_learner_record_timeout_ms
  redis_host                         = module.redis-session.redis_host
  redis_password                     = module.redis-session.redis_key
  redis_port                         = "6379"
  org_redis_host                     = module.redis-org.redis_host
  org_redis_password                 = module.redis-org.redis_key
  org_redis_port                     = "6379"
  org_redis_ttl                      = "604800"

}

module "notification-service" {
  source                             = "../../modules/notification-service"
  rg_name                            = var.rg_name
  rg_prefix                          = "${var.rg_prefix}}"
  rg_location                        = "${var.rg_location}}"
  notification_service_name          = "${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}"
  docker_tag                         = var.notification_service_tag
  docker_repository_region           = var.notification_service_docker_repository_region
  env_profile                        = var.env_profile
  authentication_service_url         = "https://identity.${var.domain}"
  docker_registry_server_url         = var.docker_registry_server_url


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
  rg_name                          = var.rg_name
  rg_prefix                        = var.rg_prefix
  rg_location                      = var.rg_location
  data_transchiver_name            = "${var.rg_prefix}-${var.rg_name}-${var.data_transchiver_name}"
  env_profile                      = var.env_profile
  webapp_sku_tier                  = var.webapp_sku_tier_p2
  webapp_sku_name                  = var.webapp_sku_name_p1
  tds_mysql_proc_registry_host     = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name_ll}.mysql.database.azure.com"
  tds_mysql_proc_registry_db_user  = "${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_ll}"
  tds_mysql_proc_registry_db_pwd   = var.mysql_pass_ll
  tds_mysql_learner_record_db_host = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com"
  tds_mysql_learner_record_db_user = "${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}"
  tds_mysql_learner_record_db_pwd  = var.mysql_pass
  tds_mysql_history_db_host        = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name_ll}.mysql.database.azure.com"
  tds_mysql_history_db_user        = "${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_ll}"
  tds_mysql_history_db_pwd         = var.mysql_pass_ll
  cosmos_src_connection_string     = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&retrywrites=false"
  data_xfr_job_schedule            = var.job_schedule
  docker_registry_server_url       = var.docker_registry_server_url


  docker_tag                       = var.data_transchiver_tag
}
