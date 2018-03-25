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
}

module "postgres" {
  source                   = "../../modules/postgres"
  rg_name                  = "${var.rg_name}"
  rg_prefix                = "${var.rg_name}"
  rg_location              = "${var.rg_location}"
  postgres_name            = "${var.rg_prefix}-${var.rg_name}-${var.postgres_name}"
  postgres_sku_name        = "${var.postgres_sku_name}"
  postgres_sku_capacity    = "${var.postgres_sku_capacity}"
  postgres_sku_tier        = "${var.postgres_sku_tier}"
  postgres_admin_login     = "${var.postgres_user}"
  postgres_admin_pass      = "${var.postgres_pass}"
  postgres_version         = "9.6"
  postgres_storage_mb      = "51200"
  postgres_ssl_enforcement = "Enabled"
}

module "cosmos" {
  source      = "../../modules/cosmos"
  rg_name     = "${var.rg_name}"
  rg_prefix   = "${var.rg_name}"
  rg_location = "${var.rg_location}"
  cosmos_name = "${var.rg_prefix}-${var.rg_name}-${var.cosmos_name}"
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
}

module "wso2" {
  source                  = "../../modules/wso2"
  rg_name                 = "${var.rg_name}"
  rg_prefix               = "${var.rg_prefix}"
  rg_location             = "${var.rg_location}"
  wso2_name               = "${var.rg_prefix}-${var.rg_name}-${var.wso2_name}"
  database_url            = "jdbc:postgresql://${var.rg_prefix}-${var.rg_name}-${var.postgres_name}.postgres.database.azure.com:5432/wso2is?user=${var.postgres_user}@${var.rg_prefix}-${var.rg_name}-${var.postgres_name}&password=${var.postgres_pass}&ssl=true"
  docker_image            = "${var.wso2_docker_image}"
  docker_tag              = "${var.wso2_docker_tag}"
  environment_tag         = "${var.environment_tag}"
  hammer_logstash_host    = "${var.hammer_logstash_host}"
  hammer_logstash_port    = "${var.hammer_logstash_port}"
  env_profile             = "${var.env_profile}"

}

module "mailhog" {
  source          = "../../modules/mailhog"
  rg_name         = "${var.rg_name}"
  rg_prefix       = "${var.rg_prefix}"
  rg_location     = "${var.rg_location}"
  mailhog_name    = "${var.rg_prefix}-${var.rg_name}-${var.mailhog_name}"
  environment_tag = "${var.environment_tag}"
}

module "lpg-learner-record" {
  source                  = "../../modules/lpg-learner-record"
  rg_name                 = "${var.rg_name}"
  rg_prefix               = "${var.rg_prefix}"
  rg_location             = "${var.rg_location}"
  lpg_learner_record_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}"
  auth_user               = "${var.lpg_learner_record_auth_user}"
  auth_password           = "${var.lpg_learner_record_auth_password}"
  docker_tag              = "${var.lpg_learner_record_docker_tag}"
  xapi_url                = "http://${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}.azurewebsites.net:8083/data/xAPI"
  environment_tag         = "${var.environment_tag}"
}

output "wso2_ip" {
  value = "${module.wso2.wso2_ip}"
}

module "lpg-learning-locker-xapi" {
  source                    = "../../modules/learning-locker-xapi"
  rg_name                   = "${var.rg_name}"
  rg_prefix                 = "${var.rg_prefix}"
  rg_location               = "${var.rg_location}"
  learning_locker_xapi_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}"
  mongo_url                 = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  mongodb_path              = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  redis_url                 = "redis://${module.redis.redis_host}:${module.redis.redis_port}/0&password=${module.redis.redis_key}&ssl=True&abortConnect=False"
  docker_tag                = "${var.ll_xapi_docker_tag}"
  environment_tag           = "${var.environment_tag}"
}

module "lpg-learning-locker-worker" {
  source                      = "../../modules/learning-locker-worker"
  rg_name                     = "${var.rg_name}"
  rg_prefix                   = "${var.rg_prefix}"
  rg_location                 = "${var.rg_location}"
  learning_locker_worker_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_worker_name}"
  mongodb_path                = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  redis_host                  = "${module.redis.redis_host}"
  docker_tag                  = "${var.ll_api_worker_docker_tag}"
  environment_tag             = "${var.environment_tag}"
  redis_port                  = "${module.redis.redis_port}"
  redis_key                   = "${module.redis.redis_key}"
  redis_db                    = "0"
  redis_prefix                = "${var.redis_prefix}"
  hammer_http_server_port     = "${var.hammer_api_worker_http_server_port}"
  hammer_logstash_host        = "${var.hammer_logstash_host}"
  hammer_logstash_port        = "${var.hammer_logstash_port}"
  env_profile                 = "${var.env_profile}"
  redis_use_tls               = "${var.redis_use_tls}"
  hammer_working_directory    = "${var.worker_api_hammer_directory}"
  websites_port               = "${var.hammer_api_worker_http_server_port}"
  queue_provider              = "REDIS"
  queue_namespace             = "learninglocker"
}

/*
Not needed...
module "lpg-learning-locker-setup" {
  source                     = "../../modules/learning-locker-setup"
  rg_name                    = "${var.rg_name}"
  rg_prefix                  = "${var.rg_prefix}"
  rg_location                = "${var.rg_location}"
  learning_locker_setup_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_setup_name}"
  mongo_url                  = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  mongodb_path               = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  redis_host                 = "${module.redis.redis_host}"
  redis_url                  = "redis://${module.redis.redis_host}:${module.redis.redis_port}/0&password=${module.redis.redis_key}&ssl=True&abortConnect=False"
  docker_tag                 = "${var.ll_setup_docker_tag}"
  environment_tag            = "${var.environment_tag}"
}
*/

module "lpg-learning-locker-api-server" {
  source                          = "../../modules/learning-locker-api-server"
  rg_name                         = "${var.rg_name}"
  rg_prefix                       = "${var.rg_prefix}"
  rg_location                     = "${var.rg_location}"
  mongodb_path                    = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  docker_tag                      = "${var.ll_api_server_docker_tag}"
  learning_locker_api_server_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_api_server_name}"
  environment_tag                 = "${var.environment_tag}"
  hammer_logstash_host            = "${var.hammer_logstash_host}"
  hammer_logstash_port            = "${var.hammer_logstash_port}"
  env_profile                     = "${var.env_profile}"
  hammer_working_directory        = "${var.server_api_hammer_directory}"
}

module "lpg-learning-locker-ui" {
  source                  = "../../modules/learning-locker-ui"
  rg_name                 = "${var.rg_name}"
  rg_prefix               = "${var.rg_prefix}"
  rg_location             = "${var.rg_location}"
  mongo_url               = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  mongodb_path            = "mongodb://${module.cosmos.cosmos_name}:${module.cosmos.cosmos_password}@${module.cosmos.cosmos_name}.documents.azure.com:10255/?ssl=true&replicaSet=globaldb"
  redis_url               = "redis://${module.redis.redis_host}:${module.redis.redis_port}/0&password=${module.redis.redis_key}&ssl=True&abortConnect=False"
  docker_tag              = "${var.ll_ui_docker_tag}"
  learning_locker_ui_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_ui_name}"
  environment_tag         = "${var.environment_tag}"
  api_host                = "http://${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_api_server_name}.azurewebsites.net"
}

module "lpg-management" {
  source                          = "../../modules/lpg-management"
  rg_name                         = "${var.rg_name}"
  rg_prefix                       = "${var.rg_prefix}"
  rg_location                     = "${var.rg_location}"
  docker_tag                      = "${var.lpg_management_docker_tag}"
  lpg_management_name             = "${var.rg_prefix}-${var.rg_name}-${var.lpg_management_name}"
  xapi_url                        = "http://${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}.azurewebsites.net:8083/data/xAPI"
  virtual_host                    = "${var.virtual_host}"
  authentication_service_url      = "${var.authentication_service_url}"
  azure_storage_connection_string = "${module.blob.storage_connection_string}"
  environment_tag                 = "${var.environment_tag}"
}

module "lpg-ui" {
  source                          = "../../modules/lpg-ui"
  rg_name                         = "${var.rg_name}"
  rg_prefix                       = "${var.rg_prefix}"
  rg_location                     = "${var.rg_location}"
  lpg_ui_name                     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_ui_name}"
  xapi_url                        = "http://${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}.azurewebsites.net:8083/data/xAPI"
  virtual_host                    = "${var.virtual_host}"
  authentication_service_url      = "${var.authentication_service_url}"
  azure_storage_connection_string = "${module.blob.storage_connection_string}"
  environment_tag                 = "${var.environment_tag}"
  course_catalogue_url            = "${var.course_catalogue_url}"
  course_catalogue_user           = "${var.course_catalogue_user}"
  course_catalogue_pass           = "${var.course_catalogue_pass}"
  learner_record_url              = "http://${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}.azurewebsites.net"
  learner_record_user             = "${var.learner_record_user}"
  learner_record_pass             = "${var.learner_record_pass}"
  youtube_api_key                 = "${var.youtube_api_key}"
  gov_notify_api_key              = "${var.gov_notify_api_key}"
  booking_alert_webhook           = "${var.booking_alert_webhook}"
}

module "lpg-learning-catalogue" {
  source                      = "../../modules/lpg-learning-catalogue"
  rg_name                     = "${var.rg_name}"
  rg_prefix                   = "${var.rg_prefix}"
  rg_location                 = "${var.rg_location}"
  lpg_learning_catalogue_name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}"
  auth_user                   = "${var.lpg_learner_record_auth_user}"
  auth_password               = "${var.lpg_learner_record_auth_password}"
  elasticsearch_host          = "${var.elasticsearch_host}"
  elasticsearch_port          = "${var.elasticsearch_port}"
  elasticsearch_cluster       = "${var.elasticsearch_cluster}"
  docker_tag                  = "${var.learning_catalogue_docker_tag}"
}
