### Gen vars ###
variable "rg_name" {
  type    = "string"
  default = "testlab"
}

variable "rg_prefix" {
  type    = "string"
  default = "lpg"
}

variable "rg_location" {
  type    = "string"
  default = "UK South"
}

variable "environment_tag" {
  type    = "string"
  default = "test"
}

### postgres ###
variable "postgres_name" {
  default = "postgres"
}

variable "postgres_sku_name" {
  default = "PGSQLB50"
}

variable "postgres_sku_capacity" {
  default = 50
}

variable "postgres_sku_tier" {
  default = "Basic"
}

variable "postgres_user" {
  default = ""
}

variable "postgres_pass" {
  default = ""
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

### wso2 ###
variable "wso2_name" {
  default = "wso2"
}

variable "wso2_docker_image" {
  default = "cshr/lpg-wso2-is"
}

variable "wso2_docker_tag" {
  default = "f4ef0183d91cd599880caf4122e88f543c2376ec"
}

### mailhog ###
variable "mailhog_name" {
  default = "mailhog"
}

### lpg-learner-record ###
variable "lpg_learner_record_name" {
  default = "lpg-learner-record"
}

variable "lpg_learner_record_docker_tag" {
  default = "0a44bda01502cfa1cfc603a79b99da2620830d58"
}

variable "lpg_learner_record_auth_user" {
  default = "user"
}

variable "lpg_learner_record_auth_password" {
  default = "password"
}

variable "xapi_url" {
  default = "xapi_url"
}

variable "lpg_learner_record_websites_port" {
  default = "9000"
}

### learning-locker-general ###
variable "ll_docker_tag" {
  default = "78d1c67e34d2e99a9d9e1c616df32589585acd14281adb8b9aff36be3067ba78"
}

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

variable "hammer_api_worker_http_server_port" {
  default = "8080"
}

variable "hammer_logstash_host" {
  default = "54e2fb5d-be7a-47c2-b3cf-6f72f42b5dfb-ls.logit.io"
}

variable "hammer_logstash_port" {
  default = "16690"
}

variable "env_profile" {
  default = "test"
}

variable "worker_api_env_app" {
  default = "learning-locker-api-worker"
}

variable "redis_use_tls" {
  default = "1"
}

variable "worker_api_hammer_directory" {
  default = "/opt/learning-locker"
}

variable "redis_queue_provider" {
  default = "REDIS"
}

variable "redis_queue_namespace" {
  default = "learninglocker"
}

variable "redis_prefix" {
  default = "learninglocker"
}

### learning-locker-setup ###
variable "lpg_learning_locker_setup_name" {
  default = "setup"
}

variable "ll_setup_docker_tag" {
  default = "fc53b8729e706154b33f384081e0f3664d7ad9e7d8a3e9ddb3fd21e9dd10e556"
}

### learning-locker-api-server ###
variable "lpg_learning_locker_api_server_name" {
  default = "learning-locker-api-server"
}

variable "server_api_hammer_directory" {
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

variable "virtual_host" {
  default = "virtual_host"
}

variable "authentication_service_url" {
  default = "auth_service_url"
}

variable "lpg_management_docker_tag" {
  default = "latest"
}

### lpg-ui ###
variable "lpg_ui_name" {
  default = "lpg-ui"
}

variable "course_catalogue_url" {
  default = "course_catalogue_url"
}

variable "course_catalogue_user" {
  default = "user"
}

variable "course_catalogue_pass" {
  default = "password"
}

variable "learner_record_url" {
  default = "learner_record_url"
}

variable "learner_record_user" {
  default = "user"
}

variable "learner_record_pass" {
  default = "password"
}

variable "youtube_api_key" {
  default = "AIzaSyDkapeVQajSishsrZTDmqi4rLRRq3HABrY"
}

variable "gov_notify_api_key" {
  default = ""
}

variable "google_analytics_id" {
  default = "UA-22141655-3"
}

variable "booking_alert_webhook" {
  default = "booking_alert_webhook"
}

### lpg-learning-catalogue ###
variable "lpg_learning_catalogue_name" {
  default = "lpg-learning-catalogue"
}

variable "elasticsearch_host" {
  default = "elasticsearch_host"
}

variable "elasticsearch_port" {
  default = "elasticsearch_port"
}

variable "elasticsearch_cluster" {
  default = "elasticsearch_cluster"
}

variable "learning_catalogue_docker_tag" {
  default = "latest"
}
