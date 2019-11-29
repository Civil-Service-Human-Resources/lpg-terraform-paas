### Gen vars ###
variable "rg_name" {
  type    = "string"
  default = "lpgstaging"
}

variable "rg_prefix" {
  type    = "string"
  default = "lpg"
} 
variable "ai_instrument_key" {
  type = "string"
  default = "96e2f499-7c6e-4cb4-b455-850a5057aa22"
}

variable "rg_location" {
  type    = "string"
  default = "UK South"
}

variable "webapp_sku_tier" {
  default = "Basic"
}

variable "webapp_sku_tier_p2" {
  default = "PremiumV2"
}

variable "webapp_sku_name_1" {
  default = "B1"
}

variable "webapp_sku_name_2" {
  default = "B2"
}

variable "webapp_sku_name_3" {
  default = "B3"
}

variable "webapp_sku_name_p1" {
  default = "P1v2"
}

variable "webapp_sku_name_p2" {
  default = "P1v2"
}

variable "identity_capacity" {
  default = "2"
}

variable "csrs_capacity" {
  default = "1"
}

variable "xapi_capacity" {
  default = "1"
}

variable "learner_record_capacity" {
  default = "1"
}

variable "learning_catalogue_capacity" {
  default = "1"
}

variable "lpg_ui_capacity" {
  default = "2"
}

variable "notification_capacity" {
  default = "1"
}

variable "envurl" {
  default = "staging-"
}

variable "domain" {
  default = "cshr.digital"
}

variable "lpgurl" {
  default = "lpg."
}

variable "scaling_enabled" {
  default = "false"
}

variable "hammer_api_worker_http_server_port" {
  default = "8080"
}

variable "env_profile" {
  default = "staging"
}

variable "youtube_api_key" {
  default = "AIzaSyDkapeVQajSishsrZTDmqi4rLRRq3HABrY"
}

variable "google_analytics_id" {
  default = "UA-22141655-3"
}

### docker tags ###
variable "civil_servant_registry_docker_tag" {
  default = "master-8"
}

variable "identity_docker_tag" {
  default = "master-4"
}

variable "identity_management_docker_tag" {
  default = "master-17"
}

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

variable "lpg_learner_record_docker_tag" {
  default = "master-5"
}

variable "learning_catalogue_docker_tag" {
  default = "master-7"
}

variable "lpg_management_tag" {
  default = "master-9"
}

variable "lpg_report_service_docker_tag" {
  default = "master-3"
}

variable "lpg_services_tag" {
  default = "master-16"
}

variable "notification_service_tag" {
  default = "master-5"
}

### cosmos ###
variable "cosmos_name" {
  default = "cosmos"
}

variable "cosmos_offer_type" {
  default = "Standard"
}

variable "cosmos_consistency_policy_level" {
  default = "Strong"
}

variable "cosmos_failover_policy_location" {
  default = "West Europe"
}

### redis ###
variable "redis_queue_provider" {
  default = "REDIS"
}

variable "redis_queue_namespace" {
  default = "learninglocker"
}

variable "redis_prefix" {
  default = "learninglocker"
}

variable "redis_use_tls" {
  default = "1"
}

variable "redis_capacity" {
  default = "0"
}

variable "redis_session_capacity" {
  default = "0"
}

### identity ###
variable "identity_name" {
  default = "identity"
}

### lpg-learner-record ###
variable "lpg_learner_record_name" {
  default = "lpg-learner-record"
}

variable "lpg_learner_record_websites_port" {
  default = "9000"
}

### learning-locker-general ###
variable "lpg_testing" {
  default = "1"
}

### learning-locker-xapi ###
variable "lpg_learning_locker_xapi_name" {
  default = "learning-locker-xapi"
}

variable "ll_xapi_express_port" {
  default = "8083"
}

### learning-locker-worker ###
variable "lpg_learning_locker_worker_name" {
  default = "learning-locker-api-worker"
}

variable "worker_api_env_app" {
  default = "learning-locker-api-worker"
}

variable "worker_api_hammer_directory" {
  default = "/opt/learning-locker"
}

### learning-locker-ui ###
variable "lpg_learning_locker_ui_name" {
  default = "learning-locker-ui"
}

variable "lpg_learning_locker_api_port" {
  default = "8082"
}

variable "ll_ui_port" {
  default = "80"
}

### lpg-ui ###
variable "lpg_ui_name" {
  default = "lpg-ui"
}

variable "ui_hammer_working_directory" {
  default = "/var/www/app/dist/ui"
}

variable "ui_websites_port" {
  default = "3001"
}

### lpg-learning-catalogue ###
variable "lpg_learning_catalogue_name" {
  default = "lpg-learning-catalogue"
}

variable "azure_account_name" {
  default = "lpgdev"
}

### mysql_gp ###
variable "mysql_name_gp" {
  default = "gp"
}

### civil-servant-registry ###
variable "civil_servant_registry_name" {
  default = "civil-servant-registry"
}

variable "lpg_report_service_name" {
  default = "lpg-report-service"
}

variable "report_service_websites_port" {
  default = "9004"
}

variable "spring_profiles_active" {
  default = "test,production"
}

variable "identity_management_name" {
  default = "identity-management"
}

### lpg-management ###
variable "lpg_management_name" {
  default = "lpg-management"
}

variable "lpg_management_hammer_working_directory" {
  default = "/var/www/app/dist/management2"
}

variable "lpg_management_websites_port" {
  default = "3005"
}

variable "content_container" {
  default = "lpgdevcontent"
}

### notification-service ###
variable "notification_service_name" {
  default = "notification-service"
}
