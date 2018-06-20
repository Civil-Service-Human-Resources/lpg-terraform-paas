### Gen vars ###
variable "rg_name" {
  type    = "string"
  default = "lpgprod"
}

variable "rg_prefix" {
  type    = "string"
  default = "lpg"
}

variable "rg_location" {
  type    = "string"
  default = "UK South"
}

variable "authentication_service_url" {
  default = "https://identity.cshr.digital"
}

variable "lpg_ui_url" {
  default = "https://lpg.cshr.digital"
}

variable "lpg_ui_server" {
  default = "lpg.cshr.digital"
}

variable "lpg_management_ui_url" {
  default = "https://management.cshr.digital"
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
  default = "prod"
}

variable "youtube_api_key" {
  default = "AIzaSyDkapeVQajSishsrZTDmqi4rLRRq3HABrY"
}

variable "google_analytics_id" {
  default = "UA-22141655-6"
}

variable "elasticsearch_uri" {
  default = "https://elastic.cshr.digital:9200"
}

variable "content_url" {
  default = "https://cdn.cshr.digital/packages"
}

variable "envurl" {
  default = ""
}

### docker tags ###
variable "identity_docker_tag" {
  default = "0.3.3.2"
}

variable "lpg_learner_record_docker_tag" {
  default = "0a44bda01502cfa1cfc603a79b99da2620830d58-v2"
}

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

variable "lpg_services_tag" {
  default = "ab1e04f5a68efb4dbea648dcfd6a2bee10751c14"
}

variable "learning_catalogue_docker_tag" {
  default = "10f5683bb8a49fc8fbbd7e48b81c31383a8e8db7"
}

variable "civil_servant_registry_docker_tag" {
  default = "latest"
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

variable "identity_docker_image" {
  default = "cshr/identity-service"
}

### lpg-learner-record ###
variable "lpg_learner_record_name" {
  default = "lpg-learner-record"
}

variable "xapi_url" {
  default = "xapi_url"
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

variable "lpg_management_server" {
  default = "https://management.cshr.digital"
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

variable "registry_service_url" {
  default = "https://civil-servant-registry.cshr.digital"
}
