module "redis" {
  source                    = "../../modules/redis"
  rg_name                   = "${var.rg_name}"
  rg_prefix                 = "${var.rg_prefix}"
  rg_location               = "${var.rg_location}"
  redis_name                = "${var.rg_prefix}-${var.rg_name}-redis"
  redis_capacity            = "2"
  redis_family              = "C"
  redis_sku_name            = "Standard"
  redis_enable_non_ssl_port = "true"
  redis_max_clients         = "2000"
  redis_maxmemory_reserved  = "2"
  redis_maxmemory_delta     = "2"
  redis_maxmemory_policy    = "volatile-lru"
  env_profile               = "${var.env_profile}"
}

module "mysql" {
  source                    = "../../modules/mysql"
  rg_name                   = "${var.rg_name}"
  rg_prefix                 = "${var.rg_name}"
  rg_location               = "${var.rg_location}"
  mysql_name                = "${var.rg_prefix}-${var.rg_name}-${var.mysql_name}"
  mysql_admin_login         = "${var.mysql_user}"
  mysql_admin_pass          = "${var.mysql_pass}"
}

module "cosmos" {
  source      = "../../modules/cosmos"
  rg_name     = "${var.rg_name}"
  rg_prefix   = "${var.rg_name}"
  rg_location = "${var.rg_location}"
  cosmos_name = "${var.rg_prefix}-${var.rg_name}-${var.cosmos_name}"
  env_profile = "${var.env_profile}"
}

module "blob" {
  source                      = "../../modules/blob"
  rg_name                     = "${var.rg_name}"
  rg_prefix                   = "${var.rg_prefix}"
  rg_location                 = "${var.rg_location}"
  storage_account_location    = "UK South"
  storage_account_name        = "${var.rg_prefix}${var.rg_name}blob"
  storage_account_tier        = "Standard"
  storage_account_replication = "ZRS"
  container_name              = "packages"
  container_accesstype        = "private"
  env_profile                 = "${var.env_profile}"
}

module "identity" {
  source                                  = "../../modules/identity"
  rg_name                                 = "${var.rg_name}"
  rg_prefix                               = "${var.rg_prefix}"
  rg_location                             = "${var.rg_location}"
  identity_name                           = "${var.rg_prefix}-${var.rg_name}-${var.identity_name}"
  datasource                              = "jdbc:mysql://${var.rg_prefix}-${var.rg_name}-${var.mysql_name}.mysql.database.azure.com:3306/oauth2?user=${var.mysql_user}@${var.rg_prefix}-${var.rg_name}-${var.mysql_name}&password=${var.postgres_pass}&useSSL=true&requireSSL=false"
  docker_image                            = "${var.identity_docker_image}"
  docker_tag                              = "${var.identity_docker_tag}"
  hammer_logstash_host                    = "${var.hammer_logstash_host}"
  hammer_logstash_port                    = "${var.hammer_logstash_port}"
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
  invite_signup_url                       = "http://${var.rg_prefix}-${var.rg_name}-${var.identity_name}.azurewebsites.net/signup/%s"
  reset_url                               = "http://${var.rg_prefix}-${var.rg_name}-${var.identity_name}.azurewebsites.net/reset/%s"
}

module "lpg-learner-record" {
  source                  = "../../modules/lpg-learner-record"
  rg_name                 = "${var.rg_name}"
  rg_prefix               = "${var.rg_prefix}"
  rg_location             = "${var.rg_location}"
  lpg_learner_record_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}"
  auth_user               = "${var.learner_record_user}"
  auth_password           = "${var.learner_record_pass}"
  docker_tag              = "${var.lpg_learner_record_docker_tag}"
  xapi_url                = "https://${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}.azurewebsites.net/data/xAPI"
  hammer_logstash_host    = "${var.hammer_logstash_host}"
  hammer_logstash_port    = "${var.hammer_logstash_port}"
  env_profile             = "${var.env_profile}"
  websites_port           = "${var.lpg_learner_record_websites_port}"
}

module "lpg-learning-locker-xapi" {
  source                    = "../../modules/learning-locker-xapi"
  rg_name                   = "${var.rg_name}"
  rg_prefix                 = "${var.rg_prefix}"
  rg_location               = "${var.rg_location}"
  learning_locker_xapi_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}"
  mongo_url                 = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  redis_url                 = "redis://${module.redis.redis_host}:${module.redis.redis_port}/0?password=${module.redis.redis_key}"
  docker_tag                = "${var.ll_docker_tag}"
  hammer_logstash_host      = "${var.hammer_logstash_host}"
  hammer_logstash_port      = "${var.hammer_logstash_port}"
  env_profile               = "${var.env_profile}"
  redis_use_tls             = "${var.redis_use_tls}"
  websites_port             = "${var.ll_xapi_express_port}"
  redis_prefix              = "${var.redis_prefix}"
  express_port              = "${var.ll_xapi_express_port}"
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
  hammer_logstash_host        = "${var.hammer_logstash_host}"
  hammer_logstash_port        = "${var.hammer_logstash_port}"
  env_profile                 = "${var.env_profile}"
  redis_use_tls               = "${var.redis_use_tls}"
  hammer_working_directory    = "${var.worker_api_hammer_directory}"
  websites_port               = "${var.hammer_api_worker_http_server_port}"
  queue_provider              = "${var.redis_queue_provider}"
  queue_namespace             = "${var.redis_queue_namespace}"
  testing                     = "${var.lpg_testing}"
}

module "lpg-learning-locker-ui" {
  source                  = "../../modules/learning-locker-ui"
  rg_name                 = "${var.rg_name}"
  rg_prefix               = "${var.rg_prefix}"
  rg_location             = "${var.rg_location}"
  mongodb_path            = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  docker_tag              = "${var.ll_docker_tag}"
  learning_locker_ui_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}"
  api_host                = "localhost"
  api_port                = "${var.lpg_learning_locker_api_port}"
  hammer_logstash_host    = "${var.hammer_logstash_host}"
  hammer_logstash_port    = "${var.hammer_logstash_port}"
  env_profile             = "${var.env_profile}"
  ui_host                 = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}.azurewebsites.net"
  ui_port                 = "${var.ll_ui_port}"
}

module "lpg-management" {
  source                          = "../../modules/lpg-management"
  rg_name                         = "${var.rg_name}"
  rg_prefix                       = "${var.rg_prefix}"
  rg_location                     = "${var.rg_location}"
  docker_tag                      = "${var.lpg_services_tag}"
  lpg_management_name             = "${var.rg_prefix}-${var.rg_name}-${var.lpg_management_name}"
  authentication_service_url      = "${var.authentication_service_url}"
  azure_storage_connection_string = "${module.blob.storage_connection_string}"
  hammer_logstash_host            = "${var.hammer_logstash_host}"
  hammer_logstash_port            = "${var.hammer_logstash_port}"
  env_profile                     = "${var.env_profile}"
  lpg_ui_server                   = "${var.lpg_ui_server}"
  session_secret                  = "${var.session_secret}"
  hammer_working_directory        = "${var.management_ui_hammer_working_directory}"
  websites_port                   = "${var.management_ui_websites_port}"
  youtube_api_key                 = "${var.youtube_api_key}"
  course_catalogue_url            = "https://${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}.azurewebsites.net"
  course_catalogue_user           = "${var.course_catalogue_user}"
  course_catalogue_pass           = "${var.course_catalogue_pass}"
  vaultresourcegroup              = "${var.vaultresourcegroup}"
  vaultname                       = "${var.vaultname}"
  existingkeyvaultsecretname      = "${var.existingkeyvaultsecretname}"
  certificatename                 = "${var.certificatename}"
  envurl                          = "${var.envurl}"
}

module "lpg-ui" {
  source                          = "../../modules/lpg-ui"
  rg_name                         = "${var.rg_name}"
  rg_prefix                       = "${var.rg_prefix}"
  rg_location                     = "${var.rg_location}"
  lpg_ui_name                     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_ui_name}"
  xapi_url                        = "https://${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}.azurewebsites.net/data/xAPI"
  authentication_service_url      = "${var.authentication_service_url}"
  azure_storage_connection_string = "${module.blob.storage_connection_string}"
  docker_tag                      = "${var.lpg_services_tag}"
  course_catalogue_url            = "https://${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}.azurewebsites.net"
  course_catalogue_user           = "${var.course_catalogue_user}"
  course_catalogue_pass           = "${var.course_catalogue_pass}"
  learner_record_url              = "https://${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}.azurewebsites.net"
  learner_record_user             = "${var.learner_record_user}"
  learner_record_pass             = "${var.learner_record_pass}"
  youtube_api_key                 = "${var.youtube_api_key}"
  gov_notify_api_key              = "${var.gov_notify_api_key}"
  hammer_logstash_host            = "${var.hammer_logstash_host}"
  hammer_logstash_port            = "${var.hammer_logstash_port}"
  env_profile                     = "${var.env_profile}"
  google_analytics_id             = "${var.google_analytics_id}"
  session_secret                  = "${var.session_secret}"
  hammer_working_directory        = "${var.ui_hammer_working_directory}"
  websites_port                   = "${var.ui_websites_port}"
  content_url                     = "${var.content_url}"
  vaultresourcegroup              = "${var.vaultresourcegroup}"
  vaultname                       = "${var.vaultname}"
  existingkeyvaultsecretname      = "${var.existingkeyvaultsecretname}"
  certificatename                 = "${var.certificatename}"
  envurl                          = "${var.envurl}"
}

module "lpg-learning-catalogue" {
  source                      = "../../modules/lpg-learning-catalogue"
  rg_name                     = "${var.rg_name}"
  rg_prefix                   = "${var.rg_prefix}"
  rg_location                 = "${var.rg_location}"
  lpg_learning_catalogue_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}"
  auth_user                   = "${var.course_catalogue_user}"
  auth_password               = "${var.course_catalogue_pass}"
  docker_tag                  = "${var.learning_catalogue_docker_tag}"
  hammer_logstash_host        = "${var.hammer_logstash_host}"
  hammer_logstash_port        = "${var.hammer_logstash_port}"
  env_profile                 = "${var.env_profile}"
  elasticsearch_uri           = "${var.elasticsearch_uri}"
  elasticsearch_user          = "${var.elasticsearch_user}"
  elasticsearch_password      = "${var.elasticsearch_password}"
}
