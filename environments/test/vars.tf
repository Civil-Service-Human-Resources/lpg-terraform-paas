### Gen vars ###
variable "rg_name" {
  type    = "string"
  default = "lpgtest"
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

variable "webapp_sku_name" {
  default = "B1"
}

variable "envurl" {
  default = "test-"
}

variable "hammer_api_worker_http_server_port" {
  default = "8080"
}

variable "env_profile" {
  default = "test"
}

variable "youtube_api_key" {
  default = "AIzaSyDkapeVQajSishsrZTDmqi4rLRRq3HABrY"
}

variable "google_analytics_id" {
  default = "UA-22141655-3"
}

### docker tags ###
variable "identity_docker_tag" {
  default = "672e7b8044cb8e7b9d870ae4957c2b7b6690e8f2"
}

variable "lpg_learner_record_docker_tag" {
  default = "feature-LPFG-396-129"
}

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

variable "lpg_services_tag" {
  default = "ee72e23ab325f68251f1769ed673a0a8eb1f5cec"
}

variable "learning_catalogue_docker_tag" {
  default = "0c764901fbc5d9d2b6d50d575751dd2b8b2bc1c3"
}

variable "civil_servant_registry_docker_tag" {
  default = "feature-LPFG-394-payment-methods-65"
}

variable "lpg_report_service_docker_tag" {
  default = "feature-lpfg-370-booking-feed-csv-report-4"
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

### lpg-management ###
variable "lpg_management_name" {
  default = "lpg-management-ui"
}

variable "management_ui_hammer_working_directory" {
  default = "/var/www/app/dist/management-ui"
}

variable "management_ui_websites_port" {
  default = "3001"
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
  default = "test"
}

variable "identity_management_name" {
  default = "identity-management"
}
