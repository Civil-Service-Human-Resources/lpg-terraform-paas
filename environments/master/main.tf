module "redis" {
  source                                  = "../../modules/redis"
  rg_name                                 = "${var.rg_name}"
  rg_prefix                               = "${var.rg_prefix}"
  rg_location                             = "${var.rg_location}"
  redis_name                              = "${var.rg_prefix}-${var.rg_name}-redis"
  env_profile                             = "${var.env_profile}"
  redis_capacity                          = "${var.redis_capacity}"
}

module "mysql" {
  source                                  = "../../modules/mysql"
  rg_name                                 = "${var.rg_name}"
  rg_prefix                               = "${var.rg_name}"
  rg_location                             = "${var.rg_location}"
  mysql_name                              = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name}"
  mysql_admin_login                       = "${var.mysql_user}"
  mysql_admin_pass                        = "${var.mysql_pass}"
  env_profile                             = "${var.env_profile}"
}

module "cosmos" {
  source                                  = "../../modules/cosmos"
  rg_name                                 = "${var.rg_name}"
  rg_prefix                               = "${var.rg_name}"
  rg_location                             = "${var.rg_location}"
  cosmos_name                             = "${var.rg_prefix}-${var.rg_name}-${var.cosmos_name}"
  env_profile                             = "${var.env_profile}"
}

module "blob" {
  source                                  = "../../modules/blob"
  rg_name                                 = "${var.rg_name}"
  rg_prefix                               = "${var.rg_prefix}"
  rg_location                             = "${var.rg_location}"
  storage_account_name                    = "${var.rg_prefix}${var.rg_name}blob"
  env_profile                             = "${var.env_profile}"
}

module "identity" {
  source                                  = "../../modules/identity"
  rg_name                                 = "${var.rg_name}"
  rg_prefix                               = "${var.rg_prefix}"
  rg_location                             = "${var.rg_location}"
  identity_name                           = "${var.rg_prefix}-${var.rg_name}-${var.identity_name}"
  datasource                              = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name}.mysql.database.azure.com:3306/identity?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  docker_tag                              = "${var.identity_docker_tag}"
  env_profile                             = "${var.env_profile}"
  gov_notify_invite_template_id           = "${var.gov_notify_invite_template_id}"
  gov_notify_reset_template_id            = "${var.gov_notify_reset_template_id}"
  gov_notify_reset_successful_template_id = "${var.gov_notify_reset_successful_template_id}"
  vaultresourcegroup                      = "${var.vaultresourcegroup}"
  vaultname                               = "${var.vaultname}"
  existingkeyvaultsecretname              = "${var.existingkeyvaultsecretname}"
  certificatename                         = "${var.certificatename}"
  gov_notify_api_key                      = "${var.gov_notify_api_key}"
  envurl                                  = "${var.envurl}"
  invite_signup_url                       = "https://${var.envurl}identity.cshr.digital/signup/%s"
  reset_url                               = "https://${var.envurl}identity.cshr.digital/reset/%s"
  webapp_sku_tier                         = "${var.webapp_sku_tier}"
  webapp_sku_name                         = "${var.webapp_sku_name_2}"
  docker_registry_server_url              = "${var.docker_registry_server_url}"
  docker_registry_server_username         = "${var.docker_registry_server_username}"
  docker_registry_server_password         = "${var.docker_registry_server_password}"
}

module "identity-management" {
  source                                  = "../../modules/identity-management"
  rg_name                                 = "${var.rg_name}"
  rg_prefix                               = "${var.rg_prefix}"
  rg_location                             = "${var.rg_location}"
  identity_management_name                = "${var.rg_prefix}-${var.rg_name}-${var.identity_management_name}"
  datasource                              = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name}.mysql.database.azure.com:3306/identity?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  docker_tag                              = "${var.identity_docker_tag}"
  env_profile                             = "${var.env_profile}"
  gov_notify_invite_template_id           = "${var.gov_notify_invite_template_id}"
  vaultresourcegroup                      = "${var.vaultresourcegroup}"
  vaultname                               = "${var.vaultname}"
  existingkeyvaultsecretname              = "${var.existingkeyvaultsecretname}"
  certificatename                         = "${var.certificatename}"
  gov_notify_api_key                      = "${var.gov_notify_api_key}"
  envurl                                  = "${var.envurl}"
  invite_signup_url                       = "https://${var.envurl}identity.cshr.digital/signup/%s"
  webapp_sku_tier                         = "${var.webapp_sku_tier}"
  webapp_sku_name                         = "${var.webapp_sku_name_1}"
  docker_registry_server_url              = "${var.docker_registry_server_url}"
  docker_registry_server_username         = "${var.docker_registry_server_username}"
  docker_registry_server_password         = "${var.docker_registry_server_password}"
}

module "lpg-learner-record" {
  source                        = "../../modules/lpg-learner-record"
  rg_name                       = "${var.rg_name}"
  rg_prefix                     = "${var.rg_prefix}"
  rg_location                   = "${var.rg_location}"
  lpg_learner_record_name       = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}"
  docker_tag                    = "${var.lpg_learner_record_docker_tag}"
  xapi_url                      = "https://${var.envurl}xapi.cshr.digital/data/xAPI"
  env_profile                   = "${var.env_profile}"
  websites_port                 = "${var.lpg_learner_record_websites_port}"
  gov_notify_api_key            = "${var.gov_notify_api_key}"
  course_catalogue_url          = "https://${var.envurl}learning-resources.cshr.digital"
  registry_service_url          = "https://${var.envurl}civil-servant-registry.cshr.digital"
  required_learning_template_id = "${var.required_learning_template_id}"
  complete_learning_template_id = "${var.complete_learning_template_id}"
  authentication_service_url    = "https://${var.envurl}identity.cshr.digital"
  learner_record_client_id      = "${var.learner_record_client_id}"
  learner_record_client_secret  = "${var.learner_record_client_secret}"
  vaultresourcegroup            = "${var.vaultresourcegroup}"
  vaultname                     = "${var.vaultname}"
  existingkeyvaultsecretname    = "${var.existingkeyvaultsecretname}"
  certificatename               = "${var.certificatename}"
  envurl                        = "${var.envurl}"
  spring_profiles_active        = "${var.spring_profiles_active}"
  datasource                    = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name}.mysql.database.azure.com:3306/learner_record?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  webapp_sku_tier               = "${var.webapp_sku_tier}"
  webapp_sku_name               = "${var.webapp_sku_name_2}"
  docker_registry_server_url      = "${var.docker_registry_server_url}"
  docker_registry_server_username = "${var.docker_registry_server_username}"
  docker_registry_server_password = "${var.docker_registry_server_password}"
}

module "lpg-report-service" {
  source                        = "../../modules/lpg-report-service"
  rg_name                       = "${var.rg_name}"
  rg_prefix                     = "${var.rg_prefix}"
  rg_location                   = "${var.rg_location}"
  lpg_report_service_name       = "${var.rg_prefix}-${var.rg_name}-${var.lpg_report_service_name}"
  docker_tag                    = "${var.lpg_report_service_docker_tag}"
  env_profile                   = "${var.env_profile}"
  websites_port                 = "${var.report_service_websites_port}"
  learner_record_url            = "https://${var.envurl}learning-record.cshr.digital"
  authentication_service_url    = "https://${var.envurl}identity.cshr.digital"
  report_service_client_id      = "${var.report_service_client_id}"
  report_service_client_secret  = "${var.report_service_client_secret}"
  vaultresourcegroup            = "${var.vaultresourcegroup}"
  vaultname                     = "${var.vaultname}"
  existingkeyvaultsecretname    = "${var.existingkeyvaultsecretname}"
  certificatename               = "${var.certificatename}"
  envurl                        = "${var.envurl}"
  webapp_sku_tier               = "${var.webapp_sku_tier}"
  webapp_sku_name               = "${var.webapp_sku_name_1}"
  docker_registry_server_url      = "${var.docker_registry_server_url}"
  docker_registry_server_username = "${var.docker_registry_server_username}"
  docker_registry_server_password = "${var.docker_registry_server_password}"
}

module "lpg-learning-locker-xapi" {
  source                      = "../../modules/learning-locker-xapi"
  rg_name                     = "${var.rg_name}"
  rg_prefix                   = "${var.rg_prefix}"
  rg_location                 = "${var.rg_location}"
  learning_locker_xapi_name   = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}"
  mongo_url                   = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  redis_url                   = "redis://${module.redis.redis_host}:${module.redis.redis_port}/0?password=${module.redis.redis_key}"
  docker_tag                  = "${var.ll_docker_tag}"
  env_profile                 = "${var.env_profile}"
  redis_use_tls               = "${var.redis_use_tls}"
  websites_port               = "${var.ll_xapi_express_port}"
  redis_prefix                = "${var.redis_prefix}"
  express_port                = "${var.ll_xapi_express_port}"
  vaultresourcegroup          = "${var.vaultresourcegroup}"
  vaultname                   = "${var.vaultname}"
  existingkeyvaultsecretname  = "${var.existingkeyvaultsecretname}"
  certificatename             = "${var.certificatename}"
  envurl                      = "${var.envurl}"
  webapp_sku_tier             = "${var.webapp_sku_tier}"
  webapp_sku_name             = "${var.webapp_sku_name_1}"
}

module "lpg-learning-locker-worker" {
  source                      = "../../modules/learning-locker-worker"
  rg_name                     = "${var.rg_name}"
  rg_prefix                   = "${var.rg_prefix}"
  rg_location                 = "${var.rg_location}"
  learning_locker_worker_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_worker_name}"
  mongodb_path                = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  redis_host                  = "${module.redis.redis_host}"
  docker_tag                  = "${var.ll_docker_tag}"
  redis_port                  = "${module.redis.redis_port}"
  redis_password              = "${module.redis.redis_key}"
  redis_db                    = "0"
  redis_prefix                = "${var.redis_prefix}"
  hammer_http_server_port     = "${var.hammer_api_worker_http_server_port}"
  env_profile                 = "${var.env_profile}"
  redis_use_tls               = "${var.redis_use_tls}"
  hammer_working_directory    = "${var.worker_api_hammer_directory}"
  websites_port               = "${var.hammer_api_worker_http_server_port}"
  queue_provider              = "${var.redis_queue_provider}"
  queue_namespace             = "${var.redis_queue_namespace}"
  testing                     = "${var.lpg_testing}"
  webapp_sku_tier             = "${var.webapp_sku_tier}"
  webapp_sku_name             = "${var.webapp_sku_name_1}"
}

module "lpg-learning-locker-ui" {
  source                      = "../../modules/learning-locker-ui"
  rg_name                     = "${var.rg_name}"
  rg_prefix                   = "${var.rg_prefix}"
  rg_location                 = "${var.rg_location}"
  mongodb_path                = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  docker_tag                  = "${var.ll_docker_tag}"
  learning_locker_ui_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}"
  api_host                    = "localhost"
  api_port                    = "${var.lpg_learning_locker_api_port}"
  env_profile                 = "${var.env_profile}"
  ui_host                     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}.azurewebsites.net"
  ui_port                     = "${var.ll_ui_port}"
  webapp_sku_tier             = "${var.webapp_sku_tier}"
  webapp_sku_name             = "${var.webapp_sku_name_1}"
}

module "lpg-ui" {
  source                          = "../../modules/lpg-ui"
  rg_name                         = "${var.rg_name}"
  rg_prefix                       = "${var.rg_prefix}"
  rg_location                     = "${var.rg_location}"
  lpg_ui_name                     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_ui_name}"
  xapi_url                        = "https://${var.envurl}xapi.cshr.digital/data/xAPI"
  authentication_service_url      = "https://${var.envurl}identity.cshr.digital"
  azure_storage_connection_string = "${var.blob_storage_connection_string}"
  docker_tag                      = "${var.lpg_services_tag}"
  course_catalogue_url            = "https://${var.envurl}learning-resources.cshr.digital"
  learner_record_url              = "https://${var.envurl}learning-record.cshr.digital"
  youtube_api_key                 = "${var.youtube_api_key}"
  gov_notify_api_key              = "${var.gov_notify_api_key}"
  env_profile                     = "${var.env_profile}"
  google_analytics_id             = "${var.google_analytics_id}"
  session_secret                  = "${var.session_secret}"
  hammer_working_directory        = "${var.ui_hammer_working_directory}"
  websites_port                   = "${var.ui_websites_port}"
  content_url                     = "https://${var.envurl}cdn.cshr.digital/${var.content_container}"
  vaultresourcegroup              = "${var.vaultresourcegroup}"
  vaultname                       = "${var.vaultname}"
  existingkeyvaultsecretname      = "${var.existingkeyvaultsecretname}"
  certificatename                 = "${var.certificatename}"
  envurl                          = "${var.envurl}"
  registry_service_url            = "https://${var.envurl}civil-servant-registry.cshr.digital"
  lpg_ui_server                   = "https://${var.envurl}lpg.cshr.digital"
  lpg_ui_oauth_client_id          = "${var.lpg_ui_oauth_client_id}"
  lpg_ui_oauth_client_secret      = "${var.lpg_ui_oauth_client_secret}"
  lpg_management_server           = "https://${var.rg_prefix}-${var.rg_name}-${var.lpg_management2_name}.azurewebsites.net"
  webapp_sku_tier                 = "${var.webapp_sku_tier}"
  webapp_sku_name                 = "${var.webapp_sku_name_2}"
  docker_registry_server_url      = "${var.docker_registry_server_url}"
  docker_registry_server_username = "${var.docker_registry_server_username}"
  docker_registry_server_password = "${var.docker_registry_server_password}"
}

module "lpg-learning-catalogue" {
  source                          = "../../modules/lpg-learning-catalogue"
  rg_name                         = "${var.rg_name}"
  rg_prefix                       = "${var.rg_prefix}"
  rg_location                     = "${var.rg_location}"
  lpg_learning_catalogue_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}"
  docker_tag                      = "${var.learning_catalogue_docker_tag}"
  env_profile                     = "${var.env_profile}"
  elasticsearch_uri               = "https://${var.envurl}elastic.cshr.digital:9200"
  elasticsearch_user              = "${var.elasticsearch_user}"
  elasticsearch_password          = "${var.elasticsearch_password}"
  vaultresourcegroup              = "${var.vaultresourcegroup}"
  vaultname                       = "${var.vaultname}"
  existingkeyvaultsecretname      = "${var.existingkeyvaultsecretname}"
  certificatename                 = "${var.certificatename}"
  envurl                          = "${var.envurl}"
  webapp_sku_tier                 = "${var.webapp_sku_tier}"
  webapp_sku_name                 = "${var.webapp_sku_name_1}"
  docker_registry_server_url      = "${var.docker_registry_server_url}"
  docker_registry_server_username = "${var.docker_registry_server_username}"
  docker_registry_server_password = "${var.docker_registry_server_password}"
  azure_account_key               = "${var.azure_account_key}"
  oauth_service_url               = "https://${var.envurl}identity.cshr.digital"
}

module "civil-servant-registry-service" {
  source                              = "../../modules/civil-servant-registry-service"
  rg_name                             = "${var.rg_name}"
  rg_prefix                           = "${var.rg_prefix}"
  rg_location                         = "${var.rg_location}"
  civil_servant_registry_name         = "${var.rg_prefix}-${var.rg_name}-${var.civil_servant_registry_name}"
  env_profile                         = "${var.env_profile}"
  docker_tag                          = "${var.civil_servant_registry_docker_tag}"
  csrs_client_id                      = "${var.csrs_client_id}"
  csrs_client_secret                  = "${var.csrs_client_secret}"
  check_token_url                     = "https://${var.envurl}identity.cshr.digital/oauth/check_token"
  datasource                          = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name}.mysql.database.azure.com:3306/csrs?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name}&password=${var.mysql_pass}&useSSL=true&requireSSL=false"
  vaultresourcegroup                  = "${var.vaultresourcegroup}"
  vaultname                           = "${var.vaultname}"
  existingkeyvaultsecretname          = "${var.existingkeyvaultsecretname}"
  certificatename                     = "${var.certificatename}"
  gov_notify_api_key                  = "${var.gov_notify_api_key}"
  envurl                              = "${var.envurl}"
  authentication_service_url          = "https://${var.envurl}identity.cshr.digital"
  webapp_sku_tier                     = "${var.webapp_sku_tier}"
  webapp_sku_name                     = "${var.webapp_sku_name_2}"
  docker_registry_server_url          = "${var.docker_registry_server_url}"
  docker_registry_server_username     = "${var.docker_registry_server_username}"
  docker_registry_server_password     = "${var.docker_registry_server_password}"
}

module "lpg-management2" {
  source                              = "../../modules/lpg-management2"
  rg_name                             = "${var.rg_name}"
  rg_prefix                           = "${var.rg_prefix}"
  rg_location                         = "${var.rg_location}"
  docker_tag                          = "${var.lpg_management2_tag}"
  lpg_management2_name                = "${var.rg_prefix}-${var.rg_name}-${var.lpg_management2_name}"
  authentication_service_url          = "https://${var.envurl}identity.cshr.digital"
  env_profile                         = "${var.env_profile}"
  session_secret                      = "${var.session_secret}"
  hammer_working_directory            = "${var.lpg_management2_hammer_working_directory}"
  websites_port                       = "${var.lpg_management2_websites_port}"
  vaultresourcegroup                  = "${var.vaultresourcegroup}"
  vaultname                           = "${var.vaultname}"
  existingkeyvaultsecretname          = "${var.existingkeyvaultsecretname}"
  certificatename                     = "${var.certificatename}"
  envurl                              = "${var.envurl}"
  lpg_management2_oauth_client_id     = "${var.lpg_management2_oauth_client_id}"
  lpg_management2_oauth_client_secret = "${var.lpg_management2_oauth_client_secret}"
  callback_url                        = "https://${var.rg_prefix}-${var.rg_name}-${var.lpg_management2_name}.azurewebsites.net"
  lpg_ui_url                          = "https://${var.envurl}lpg.cshr.digital"
  course_catalogue_url                = "https://${var.envurl}learning-resources.cshr.digital"
  content_url                         = "https://${var.envurl}cdn.cshr.digital/${var.content_container}"
  youtube_api_key                     = "${var.youtube_api_key}"
  docker_registry_server_url          = "${var.docker_registry_server_url}"
  docker_registry_server_username     = "${var.docker_registry_server_username}"
  docker_registry_server_password     = "${var.docker_registry_server_password}"
  webapp_sku_tier                     = "${var.webapp_sku_tier}"
  webapp_sku_name                     = "${var.webapp_sku_name_1}"
  registry_service_url                = "https://${var.envurl}civil-servant-registry.cshr.digital"
}

module "notification-service" {
  source                                    = "../../modules/notification-service"
  rg_name                                   = "${var.rg_name}"
  rg_prefix                                 = "${var.rg_prefix}}"
  rg_location                               = "${var.rg_location}}"
  notification_service_name                 = "${var.rg_prefix}-${var.rg_name}-${var.notification_service_name}"
  docker_tag                                = "${var.notification_service_tag}"
  env_profile                               = "${var.env_profile}"
  gov_notify_api_key                        = "${var.gov_notify_api_key}"
  gov_notify_invite_template_id             = "${var.gov_notify_invite_template_id}"
  gov_notify_reset_template_id              = "${var.gov_notify_reset_template_id}"
  gov_notify_reset_successful_template_id   = "${var.gov_notify_reset_successful_template_id}"
  gov_notify_event_invite_template_id       = "${var.gov_notify_event_invite_template_id}"
  gov_notify_event_cancellation_template_id = "${var.gov_notify_event_cancellation_template_id}"
  docker_registry_server_url                = "${var.docker_registry_server_url}"
  docker_registry_server_username           = "${var.docker_registry_server_username}"
  docker_registry_server_password           = "${var.docker_registry_server_password}"
  webapp_sku_tier                           = "${var.webapp_sku_tier}"
  webapp_sku_name                           = "${var.webapp_sku_name_1}"
}
