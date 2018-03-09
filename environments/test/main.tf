module "redis" {
  source                    = "../../modules/redis"
  rg_name                   = "${var.rg_name}"
  rg_prefix                 = "${var.rg_prefix}"
  rg_location               = "${var.rg_location}"
  redis_name                = "${var.rg_prefix}-${var.rg_name}-redis"
  redis_capacity            = "1"
  redis_family              = "P"
  redis_sku_name            = "Premium"
  redis_enable_non_ssl_port = "true"
  redis_shard_count         = "1"
  redis_max_clients         = "7500"
  redis_maxmemory_reserved  = "2"
  redis_maxmemory_delta     = "2"
  redis_maxmemory_policy    = "allkeys-lru"
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
  postgres_admin_login     = ""
  postgres_admin_pass      = ""
  postgres_version         = "9.6"
  postgres_storage_mb      = "51200"
  postgres_ssl_enforcement = "Enabled"
}

module "cosmos" {
  source                = "../../modules/cosmos"
  rg_name               = "${var.rg_name}"
  rg_prefix             = "${var.rg_name}"
  rg_location           = "${var.rg_location}"
  cosmos_name           = "${var.rg_prefix}-${var.rg_name}-${var.cosmos_name}"
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
  database_url            = "${var.rg_prefix}-${var.rg_name}-${var.postgres_name}.postgres.database.azure.com:5432/wso2is"
  lpg_ui_url              = "${var.lpg_ui_url}"
  app_service_sku         = "${var.app_service_sku}"
  app_service_sku_code    = "${var.app_service_sku_code}"
  app_service_worker_size = "${var.app_service_worker_size}"
  docker_image            = "${var.wso2_docker_image}"
  docker_tag              = "${var.wso2_docker_tag}"
  database_user           = ""
  database_password       = ""
}

module "mailhog" {
  source                  = "../../modules/mailhog"
  rg_name                 = "${var.rg_name}"
  rg_prefix               = "${var.rg_prefix}"
  rg_location             = "${var.rg_location}"
  mailhog_name            = "${var.rg_prefix}-${var.rg_name}-${var.mailhog_name}"
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
  xapi_url                = "${var.xapi_url}"
}

output "wso2_ip" {
  value = "${module.wso2.wso2_ip}"
}

module "azmssql" {
  source        = "../../modules/azmssql"
  rg_name       = "${var.rg_name}"
  rg_prefix     = "${var.rg_prefix}"
  rg_location   = "${var.rg_location}"
  sql_serv_name = "${var.rg_prefix}${var.rg_name}${var.sql_serv_name}"
  sql_admin     = ""
  sql_pass      = ""
  sql_db_name   = "${var.rg_prefix}-${var.rg_name}-db"
  outbound_ips  = "${module.wso2.wso2_ip}"
}

module "lpg-learning-locker-xapi" {
  source                        = "../../modules/learning-locker-xapi"
  rg_name                       = "${var.rg_name}"
  rg_prefix                     = "${var.rg_prefix}"
  rg_location                   = "${var.rg_location}"
  learning_locker_xapi_name     = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_locker_xapi_name}"
  mongo_url                     = "mongodb://${var.rg_prefix}-${var.rg_name}-${var.cosmos_name}.documents.azure.com/learninglocker"
  mongodb_path                  = "mongodb://${var.rg_prefix}-${var.rg_name}-${var.cosmos_name}.documents.azure.com/learninglocker"
  redis_host                    = "${var.rg_prefix}-${var.rg_name}-redis.redis.cache.windows.net"
  redis_url                     = "redis://${var.rg_prefix}-${var.rg_name}-redis.redis.cache.windows.net:6379/0"
}