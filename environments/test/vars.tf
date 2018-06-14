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

variable "authentication_service_url" {
  default = "https://test-identity.cshr.digital"
}

variable "lpg_ui_url" {
  default = "https://test-lpg.cshr.digital"
}

variable "lpg_ui_server" {
  default = "test-lpg.cshr.digital"
}

variable "lpg_management_ui_url" {
  default = "https://test-management.cshr.digital"
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

variable "youtube_api_key" {
  default = "AIzaSyDkapeVQajSishsrZTDmqi4rLRRq3HABrY"
}

variable "google_analytics_id" {
  default = "UA-22141655-3"
}

variable "elasticsearch_uri" {
  default = "https://test-elastic.cshr.digital:9200"
}

variable "content_url" {
  default = "https://test-cdn.cshr.digital/lpgdevcontent"
}

variable "envurl" {
  default = "test-"
}

### docker tags ###
variable "identity_docker_tag" {
  default = "373d498d701623d70cf8b7a29973cff3622e22eb"
}

variable "lpg_learner_record_docker_tag" {
  default = "c9baf7c8cca6484d9a195c7fb33bbb5bc53a72d0"
}

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

variable "lpg_services_tag" {
  default = "4efd7f98a3bf8bd7b3cac770d4329852ddb070cb"
}

variable "learning_catalogue_docker_tag" {
  default = "8bfe9d8df2dc89dbc16ec0840035c0a4d2bdf5ae"
}

variable "civil_servant_registry_docker_tag" {
  default = "27f7d576b080447f8b3d939337c60a57910c430e"
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
  default = "https://test-management.cshr.digital"
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
  default = "https://test-civil-servant-registry.cshr.digital"
}

variable "learner_record_url" {
  default = "https://test-learning-record.cshr.digital"
}

variable "lpg_report_service_name" {
  default = "lpg-report-service"
}

variable "report_service_websites_port" {
  default = "9004"
}

variable "report_service_url" {
  default = "https://test-report.cshr.digital"
}

variable "spring_profiles_active" {
  default = "test"
}
