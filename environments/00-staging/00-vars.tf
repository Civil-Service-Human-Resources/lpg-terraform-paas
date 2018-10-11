### Gen vars ###
variable "rg_name" {
  type    = "string"
  default = "lpgstaging"
}

variable "rg_prefix" {
  type    = "string"
  default = "lpg"
}

variable "rg_location" {
  type    = "string"
  default = "UK South"
}

variable "webapp_sku_tier" {
  default = "Basic"
}

variable "webapp_sku_name_1" {
  default = "B1"
}

variable "webapp_sku_name_2" {
  default = "B2"
}

variable "envurl" {
  default = "staging-"
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
variable "identity_docker_tag" {
  default = "chore-performance-156"
}

variable "lpg_learner_record_docker_tag" {
  default = "87fbada730d6f6914828739c6c6cf39551f351eb"
}

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

variable "lpg_services_tag" {
  default = "339f8471bcdd19dc868993322288a17a20dcb1c6"
}

variable "learning_catalogue_docker_tag" {
  default = "e01118fe2772981bcf166527cd14ff88bb382400"
}

variable "civil_servant_registry_docker_tag" {
  default = "feature-LPFG-394-payment-methods-65"
}

variable "lpg_report_service_docker_tag" {
  default = "feature-lpfg-370-booking-feed-csv-report-4"
}

variable "lpg_management2_tag" {
  default = "c555e66f89e0aa73c2c04c4bc498288918dfed1c"
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

### mysql ###
variable "mysql_name" {
  default = "mysql"
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

### lpg-management2 ###
variable "lpg_management2_name" {
  default = "lpg-management2"
}

variable "lpg_management2_hammer_working_directory" {
  default = "/var/www/app/dist/management2"
}

variable "lpg_management2_websites_port" {
  default = "3005"
}

variable "content_container" {
  default = "lpgdevcontent"
}
