### Gen vars ###
variable "rg_name" {
  type    = "string"
  default = "lpgdev2"
}

variable "rg_prefix" {
  type    = "string"
  default = "lpg"
}

variable "rg_location" {
  type    = "string"
  default = "UK South"
}

variable "lpg_ui_url" {
  default = "https://dev2-lpg.cshr.digital"
}

variable "lpg_ui_server" {
  default = "dev2-lpg.cshr.digital"
}

variable "lpg_management_ui_url" {
  default = "https://dev2-management.cshr.digital"
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
  default = "dev2"
}

variable "youtube_api_key" {
  default = "AIzaSyDkapeVQajSishsrZTDmqi4rLRRq3HABrY"
}

variable "google_analytics_id" {
  default = "UA-22141655-3"
}

variable "elasticsearch_uri" {
  default = "https://dev2-elastic.cshr.digital:9200"
}

variable "content_url" {
  default = "https://dev2-cdn.cshr.digital/lpgdevcontent"
}

variable "envurl" {
  default = "dev2-"
}

### docker tags ###
variable "identity_docker_tag" {
  default = "373d498d701623d70cf8b7a29973cff3622e22eb"
}

variable "lpg_learner_record_docker_tag" {
  default = "a76aae45b73bfcde447a455b013c58e178f9f917"
}

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

variable "lpg_services_tag" {
  default = "latest"
}

variable "learning_catalogue_docker_tag" {
  default = "222b2025e3c8f3ec2ad29b65304edc0f2a5a642d"
}

variable "civil_servant_registry_docker_tag" {
  default = "9fe7cd23d21b7428786e14f6a8c3a548b6a7211f"
}

variable "lpg_report_service_docker_tag" {
  default = "95d6bc36ffb26ee11d796c75b093b3b0684f8c2d"
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
  default = "https://dev2-management.cshr.digital"
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
  default = "https://dev2-civil-servant-registry.cshr.digital"
}

variable "learner_record_url" {
  default = "https://dev2-learner-record.cshr.digital"
}

variable "lpg_report_service_name" {
  default = "lpg-report-service"
}

variable "report_service_websites_port" {
  default = "9004"
}

variable "identity_management_name" {
  default = "identity_management"
}