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

module "blob" {
  source               = "../../modules/blob"
  rg_name              = var.rg_name
  rg_prefix            = var.rg_prefix
  rg_location          = var.rg_location
  storage_account_name = "${var.rg_prefix}${var.rg_name}blob"
  env_profile          = var.env_profile
}

module "identity" {
  source                                  = "../../modules/identity"
  rg_name                                 = var.rg_name
  rg_prefix                               = var.rg_prefix
  rg_location                             = var.rg_location
  identity_name                           = "${var.rg_prefix}-${var.rg_name}-${var.identity_name}"
  domain                                  = var.domain
  datasource                              = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/identity?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  docker_tag                              = var.identity_docker_tag
  env_profile                             = var.env_profile
  gov_notify_invite_template_id           = var.gov_notify_invite_template_id
  gov_notify_reset_template_id            = var.gov_notify_reset_template_id
  gov_notify_reset_successful_template_id = var.gov_notify_reset_successful_template_id
  vaultresourcegroup                      = var.vaultresourcegroup
  vaultname                               = var.vaultname
  existingkeyvaultsecretname              = var.existingkeyvaultsecretname
  certificatename                         = var.certificatename
  gov_notify_api_key                      = var.gov_notify_api_key
  envurl                                  = var.envurl
  whitelisted_domains                     = var.whitelisted_domains
  invite_signup_url                       = "https://${var.envurl}identity.${var.domain}/signup/%s"
  reset_url                               = "https://${var.envurl}identity.${var.domain}/reset/%s"
  lpg_ui_url                              = "https://${var.envurl}${var.lpgurl}${var.domain}"
  redis_host                              = module.redis-session.redis_host
  redis_password                          = module.redis-session.redis_key
  redis_port                              = "6379"
  scaling_enabled                         = var.scaling_enabled
  custom_emails                           = var.custom_emails
  webapp_sku_tier                         = var.webapp_sku_tier_p2
  webapp_sku_name                         = var.webapp_sku_name_p2
  identity_capacity                       = var.identity_capacity
  docker_registry_server_url              = var.docker_registry_server_url
  docker_registry_server_username         = var.docker_registry_server_username
  docker_registry_server_password         = var.docker_registry_server_password
  authentication_service_url              = "https://${var.envurl}identity.${var.domain}"
  ai_instrument_key                       = var.ai_instrument_key
  registry_service_url                    = "https://${var.envurl}civil-servant-registry.${var.domain}"
  jwt_key                                 = var.jwt_key
  invite_validity                         = var.invite_validity
  duration_after_rereg_allowed_seconds    = var.duration_after_rereg_allowed_seconds
  maintenance_page_enabled                = var.maintenance_page_enabled
  maintenance_page_content_line_1         = var.maintenance_page_content_line_1
  maintenance_page_content_line_2         = var.maintenance_page_content_line_2
  maintenance_page_content_line_3         = var.maintenance_page_content_line_3
  maintenance_page_content_line_4         = var.maintenance_page_content_line_4
}

module "identity-management" {
  source                            = "../../modules/identity-management"
  rg_name                           = var.rg_name
  rg_prefix                         = var.rg_prefix
  rg_location                       = var.rg_location
  identity_management_name          = "${var.rg_prefix}-${var.rg_name}-${var.identity_management_name}"
  docker_tag                        = var.identity_management_docker_tag
  env_profile                       = var.env_profile
  datasource                        = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/identity?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  authentication_service_url        = "https://${var.envurl}identity.${var.domain}"
  identity_management_client_id     = var.identity_management_client_id
  identity_management_client_secret = var.identity_management_client_secret
  learner_record_url                = "https://${var.envurl}learning-record.${var.domain}"
  registry_service_url              = "https://${var.envurl}civil-servant-registry.${var.domain}"
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
  docker_registry_server_username   = var.docker_registry_server_username
  docker_registry_server_password   = var.docker_registry_server_password
  jwt_key                           = var.jwt_key
}

module "lpg-learner-record" {
  source                          = "../../modules/lpg-learner-record"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  lpg_learner_record_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}"
  domain                          = var.domain
  docker_tag                      = var.lpg_learner_record_docker_tag
  xapi_url                        = "https://${var.envurl}xapi.${var.domain}/data/xAPI"
  env_profile                     = var.env_profile
  websites_port                   = var.lpg_learner_record_websites_port
  gov_notify_api_key              = var.gov_notify_api_key
  course_catalogue_url            = "https://${var.envurl}learning-resources.${var.domain}"
  registry_service_url            = "https://${var.envurl}civil-servant-registry.${var.domain}"
  required_learning_template_id   = var.required_learning_template_id
  complete_learning_template_id   = var.complete_learning_template_id
  authentication_service_url      = "https://${var.envurl}identity.${var.domain}"
  learner_record_client_id        = var.learner_record_client_id
  learner_record_client_secret    = var.learner_record_client_secret
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  spring_profiles_active          = var.spring_profiles_active
  datasource                      = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/learner_record?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  lpg_ui_url                      = "https://${var.envurl}${var.lpgurl}${var.domain}"
  notification_service_url        = "https://${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}.azurewebsites.net"
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p2
  learner_record_capacity         = var.learner_record_capacity
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  cosmos_connection_string        = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false"
  database                        = "admin"
  ai_instrument_key               = var.ai_instrument_key
  xapi_username                   = var.xapi_username
  xapi_password                   = var.xapi_password
  learner_record_command_line     = var.learner_record_command_line
  jwt_key                         = var.jwt_key
}

module "lpg-report-service" {
  source                          = "../../modules/lpg-report-service"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  lpg_report_service_name         = "${var.rg_prefix}-${var.rg_name}-${var.lpg_report_service_name}"
  domain                          = var.domain
  docker_tag                      = var.lpg_report_service_docker_tag
  env_profile                     = var.env_profile
  websites_port                   = var.report_service_websites_port
  learner_record_url              = "https://${var.envurl}learning-record.${var.domain}"
  authentication_service_url      = "https://${var.envurl}identity.${var.domain}"
  course_catalogue_url            = "https://${var.envurl}learning-resources.${var.domain}"
  registry_service_url            = "https://${var.envurl}civil-servant-registry.${var.domain}"
  report_service_client_id        = var.report_service_client_id
  report_service_client_secret    = var.report_service_client_secret
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p3
  ai_instrument_key               = var.ai_instrument_key
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  report_service_command_line     = var.report_service_command_line
  datasource                      = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/learner_record?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  jwt_key                         = var.jwt_key
}

module "lpg-learning-locker-xapi" {
  source                          = "../../modules/learning-locker-xapi"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  learning_locker_xapi_name       = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}"
  domain                          = var.domain
  mongo_url                       = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false"
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
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
}

module "lpg-learning-locker-worker" {
  source                          = "../../modules/learning-locker-worker"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  learning_locker_worker_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_worker_name}"
  mongodb_path                    = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false"
  redis_host                      = module.redis.redis_host
  docker_tag                      = var.ll_docker_tag
  redis_port                      = module.redis.redis_port
  redis_password                  = module.redis.redis_key
  redis_db                        = "0"
  redis_prefix                    = var.redis_prefix
  hammer_http_server_port         = var.hammer_api_worker_http_server_port
  env_profile                     = var.env_profile
  redis_use_tls                   = var.redis_use_tls
  hammer_working_directory        = var.worker_api_hammer_directory
  websites_port                   = var.hammer_api_worker_http_server_port
  queue_provider                  = var.redis_queue_provider
  queue_namespace                 = var.redis_queue_namespace
  testing                         = var.lpg_testing
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
}

module "lpg-learning-locker-ui" {
  source                          = "../../modules/learning-locker-ui"
  rg_name                         = var.rg_name
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  mongodb_path                    = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false"
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
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
}

module "lpg-ui" {
  source                          = "../../modules/lpg-ui"
  rg_prefix                       = var.rg_prefix
  rg_location                     = var.rg_location
  rg_name_lpg_ui                  = var.rg_name_lpg_ui
  serviceplan_suffix_lpgui        = var.serviceplan_suffix_lpgui
  lpg_ui_name                     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_ui_name}"
  domain                          = var.domain
  lpgurl                          = var.lpgurl
  xapi_url                        = "https://${var.envurl}xapi.${var.domain}/data/xAPI"
  authentication_service_url      = "https://${var.envurl}identity.${var.domain}"
  docker_tag                      = var.lpg_services_tag
  course_catalogue_url            = "https://${var.envurl}learning-resources.${var.domain}"
  learner_record_url              = "https://${var.envurl}learning-record.${var.domain}"
  youtube_api_key                 = var.youtube_api_key
  gov_notify_api_key              = var.gov_notify_api_key
  env_profile                     = var.env_profile
  google_analytics_id             = var.google_analytics_id
  session_secret                  = var.session_secret
  hammer_working_directory        = var.ui_hammer_working_directory
  websites_port                   = var.ui_websites_port
  content_url                     = "https://${var.envurl}cdn.${var.domain}/${var.content_container}"
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  registry_service_url            = "https://${var.envurl}civil-servant-registry.${var.domain}"
  lpg_ui_server                   = "https://${var.envurl}${var.lpgurl}${var.domain}"
  lpg_ui_oauth_client_id          = var.lpg_ui_oauth_client_id
  lpg_ui_oauth_client_secret      = var.lpg_ui_oauth_client_secret
  lpg_management_server           = "https://${var.envurl}management.${var.domain}"
  feedback_recipient              = var.feedback_recipient
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p2
  lpg_ui_capacity                 = var.lpg_ui_capacity
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  ai_instrument_key               = var.ai_instrument_key
  redis_host                      = module.redis-session.redis_host
  redis_password                  = module.redis-session.redis_key
  redis_port                      = "6379"
  xapi_username                   = var.xapi_username
  xapi_password                   = var.xapi_password
  ui_static_asset_root            = "https://${var.ui_static_asset_root}.azureedge.net"
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
  env_profile                     = var.env_profile
  elasticsearch_uri               = "https://${var.envurl}elastic.${var.domain}:9200"
  elasticsearch_user              = var.elasticsearch_user
  elasticsearch_password          = var.elasticsearch_password
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  envurl                          = var.envurl
  azure_account_key               = var.azure_account_key
  azure_account_name              = var.azure_account_name
  azure_storage_container         = var.content_container
  oauth_service_url               = "https://${var.envurl}identity.${var.domain}"
  client_id                       = var.lpg_learning_catalogue_oauth_client_id
  client_secret                   = var.lpg_learning_catalogue_oauth_client_secret
  learner_record_url              = "https://${var.envurl}learning-record.${var.domain}"
  registry_service_url            = "https://${var.envurl}civil-servant-registry.${var.domain}"
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  ai_instrument_key               = var.ai_instrument_key
  learning_catalogue_capacity     = var.learning_catalogue_capacity
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  jwt_key                         = var.jwt_key
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
  csrs_client_id                  = var.csrs_client_id
  csrs_client_secret              = var.csrs_client_secret
  check_token_url                 = "https://${var.envurl}identity.${var.domain}/oauth/check_token"
  datasource                      = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}.mysql.database.azure.com:3306/csrs?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name_gp}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  vaultresourcegroup              = var.vaultresourcegroup
  vaultname                       = var.vaultname
  existingkeyvaultsecretname      = var.existingkeyvaultsecretname
  certificatename                 = var.certificatename
  gov_notify_api_key              = var.gov_notify_api_key
  envurl                          = var.envurl
  authentication_service_url      = "https://${var.envurl}identity.${var.domain}"
  webapp_sku_tier                 = var.webapp_sku_tier_p2
  webapp_sku_name                 = var.webapp_sku_name_p1
  csrs_capacity                   = var.csrs_capacity
  docker_registry_server_url      = var.docker_registry_server_url
  docker_registry_server_username = var.docker_registry_server_username
  docker_registry_server_password = var.docker_registry_server_password
  ai_instrument_key               = var.ai_instrument_key
  scaling_enabled                 = var.scaling_enabled
  custom_emails                   = var.custom_emails
  agency_token_max_capacity       = var.agency_token_max_capacity
  agency_token_min_capacity       = var.agency_token_min_capacity
  jwt_key                         = var.jwt_key
  redis_host                      = module.redis-org.redis_host
  redis_password                  = module.redis-org.redis_key
  redis_port                      = "6379"
}

module "lpg-management" {
  source                             = "../../modules/lpg-management"
  rg_name                            = var.rg_name
  rg_prefix                          = var.rg_prefix
  rg_location                        = var.rg_location
  docker_tag                         = var.lpg_management_tag
  lpg_management_name                = "${var.rg_prefix}-${var.rg_name}-${var.lpg_management_name}"
  domain                             = var.domain
  authentication_service_url         = "https://${var.envurl}identity.${var.domain}"
  env_profile                        = var.env_profile
  session_secret                     = var.session_secret
  hammer_working_directory           = var.lpg_management_hammer_working_directory
  websites_port                      = var.lpg_management_websites_port
  vaultresourcegroup                 = var.vaultresourcegroup
  vaultname                          = var.vaultname
  existingkeyvaultsecretname         = var.existingkeyvaultsecretname
  certificatename                    = var.certificatename
  envurl                             = var.envurl
  lpg_management_oauth_client_id     = var.lpg_management_oauth_client_id
  lpg_management_oauth_client_secret = var.lpg_management_oauth_client_secret
  callback_url                       = "https://${var.envurl}management.${var.domain}"
  lpg_ui_url                         = "https://${var.envurl}${var.lpgurl}${var.domain}"
  report_service_url                 = "https://${var.envurl}report.${var.domain}"
  course_catalogue_url               = "https://${var.envurl}learning-resources.${var.domain}"
  content_url                        = "https://${var.envurl}cdn.${var.domain}/${var.content_container}"
  youtube_api_key                    = var.youtube_api_key
  docker_registry_server_url         = var.docker_registry_server_url
  docker_registry_server_username    = var.docker_registry_server_username
  docker_registry_server_password    = var.docker_registry_server_password
  webapp_sku_tier                    = var.webapp_sku_tier_p2
  webapp_sku_name                    = var.webapp_sku_name_p2
  lpg_management_capacity            = var.lpg_management_capacity
  registry_service_url               = "https://${var.envurl}civil-servant-registry.${var.domain}"
  learner_record_url                 = "https://${var.envurl}learning-record.${var.domain}"
  redis_host                         = module.redis-session.redis_host
  redis_password                     = module.redis-session.redis_key
  redis_port                         = "6379"
}

module "notification-service" {
  source                             = "../../modules/notification-service"
  rg_name                            = var.rg_name
  rg_prefix                          = "${var.rg_prefix}}"
  rg_location                        = "${var.rg_location}}"
  notification_service_name          = "${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}"
  docker_tag                         = var.notification_service_tag
  env_profile                        = var.env_profile
  gov_notify_api_key                 = var.gov_notify_api_key
  authentication_service_url         = "https://${var.envurl}identity.${var.domain}"
  notification_service_client_id     = var.notification_service_client_id
  notification_service_client_secret = var.notification_service_client_secret
  docker_registry_server_url         = var.docker_registry_server_url
  docker_registry_server_username    = var.docker_registry_server_username
  docker_registry_server_password    = var.docker_registry_server_password
  webapp_sku_tier                    = var.webapp_sku_tier_p2
  webapp_sku_name                    = var.webapp_sku_name_p1
  ai_instrument_key                  = var.ai_instrument_key
  notification_capacity              = var.notification_capacity
  jwt_key                            = var.jwt_key
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
  ai_instrument_key                = var.ai_instrument_key
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
  cosmos_src_connection_string     = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false"
  data_xfr_job_schedule            = var.job_schedule
  docker_registry_server_url       = var.docker_registry_server_url
  docker_registry_server_username  = var.docker_registry_server_username
  docker_registry_server_password  = var.docker_registry_server_password
  docker_tag                       = var.data_transchiver_tag
}
