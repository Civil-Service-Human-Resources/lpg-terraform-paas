### Gen vars ###
variable "rg_name" {
  type    = string
  default = "lpgprod"
}

variable "rg_name_lpg_ui" {
  type = string
  default = "lpgprod2"
}

variable "rg_prefix" {
  type    = string
  default = "lpg"
}

variable "rg_location" {
  type    = string
  default = "UK South"
}

variable "serviceplan_suffix" {
  type = string
  default = "serviceplan"
}

variable "serviceplan_suffix_lpgui" {
  type = string
  default = "serviceplan2"
}

variable "webapp_sku_tier" {
  default = "Standard"
}

variable "webapp_sku_tier_p2" {
  default = "PremiumV2"
}

variable "webapp_sku_name_1" {
  default = "S1"
}

variable "webapp_sku_name_2" {
  default = "S2"
}

variable "webapp_sku_name_3" {
  default = "S3"
}

variable "webapp_sku_name_p1" {
  default = "P1v2"
}

variable "webapp_sku_name_p2" {
  default = "P2v2"
}

variable "webapp_sku_name_p3" {
  default = "P3v2"
}

variable "identity_capacity" {
  default = "10"
}

variable "csrs_capacity" {
  default = "10"
}

variable "xapi_capacity" {
  default = "5"
}

variable "learner_record_capacity" {
  default = "10"
}

variable "learning_catalogue_capacity" {
  default = "10"
}

variable "lpg_ui_capacity" {
  default = "10"
}

variable "notification_capacity" {
  default = "2"
}

variable "lpg_management_capacity" {
  default = "2"
}

variable "envurl" {
  default = ""
}

variable "domain" {
  default = "learn.civilservice.gov.uk"
}

variable "scaling_enabled" {
  default = "false"
}

variable "env_profile" {
  default = "prod"
}

variable "google_analytics_id" {
  default = "UA-22141655-6"
}

### docker tags ###
variable "civil_servant_registry_docker_tag" {
  default = "idt-release-4.0-1-20210329-091016"
}

variable "identity_docker_tag" {
  default = "idt-release-4.0-1-20210329-090558"
}

variable "identity_management_docker_tag" {
  default = "idt-release-5.0-1"
}

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

variable "lpg_learner_record_docker_tag" {
  default = "idt-release-4.0-1-20210329-114134"
}

variable "learning_catalogue_docker_tag" {
  default = "idt-release-6.0-1-20210614-152712"
}

variable "lpg_management_tag" {
  default = "idt-release-5.0-3-20210517-105421"
}

variable "lpg_report_service_docker_tag" {
  default = "idt-release-5.0-2-20210514-083933"
}

variable "lpg_services_tag" {
  default = "idt-release-6.0-1-20210614-152635"
}

variable "notification_service_tag" {
  default = "master-7"
}

variable "data_transchiver_tag" {
  default = "master-12"
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
  default = "2"
}

variable "redis_session_capacity" {
  default = "1"
}

variable "redis_org_capacity" {
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

variable "learner_record_command_line" {
  default = "java -Xmx7g -Xms3g -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
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

variable "ui_websites_port" {
  default = "3001"
}

variable "ui_server_timeout_ms" {
  default = "235000"
}

variable "ui_static_asset_ttl" {
  default = "86400000"
}

variable "ui_static_asset_root" {
  default = "https://lpgprodstaticcontent.azureedge.net"
}

### lpg-learning-catalogue ###
variable "lpg_learning_catalogue_name" {
  default = "lpg-learning-catalogue"
}

variable "azure_account_name" {
  default = "lpglpgprodblob"
}

### mysql_gp ###
variable "mysql_name_gp" {
  default = "gp"
}

### mysql_ll ###
variable "mysql_name_ll" {
  default = "ll"
}

variable "mysql_storage" {
  default = "4194304"
}

### civil-servant-registry ###
variable "civil_servant_registry_name" {
  default = "civil-servant-registry"
}

variable "agency_token_max_capacity" {
  default = "5000"
}

variable "agency_token_min_capacity" {
  default = "1"
}

variable "lpg_report_service_name" {
  default = "lpg-report-service"
}

variable "report_service_websites_port" {
  default = "9004"
}

variable "report_service_command_line" {
  default = "java -Xmx7g -Xms3g -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
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

variable "lpg_management_websites_port" {
  default = "3005"
}

variable "content_container" {
  default = "packages"
}

variable "lpg_management_report_service_timeout_ms" {
  default = "235000"
}

variable "lpg_management_request_timeout_ms" {
  default = "60000"
}

variable "lpg_management_server_timeout_ms" {
  default = "235000"
}

variable "lpg_management_authentication_service_timeout_ms" {
  default = "60000"
}

variable "lpg_management_youtube_timeout_ms" {
  default = "60000"
}

variable "lpg_management_course_catalogue_timeout_ms" {
  default = "60000"
}

variable "lpg_management_learner_record_timeout_ms" {
  default = "60000"
}

variable "lpg_management_civil_servant_registry_service_timeout_ms" {
  default = "60000"
}

### notification-service ###
variable "notification_service_name" {
  default = "notification-service"
}

variable "feedback_recipient" {
  default = "feedback@cslearning.gov.uk"
}

### data-transchriver ###ß
variable "data_transchiver_name" {
  default = "lpg-data-transchriver"
}

variable "job_schedule" {
  default = "0 0 19 * * *"
}
variable "invite_validity" {
  default = "259200"
}
variable "duration_after_rereg_allowed_seconds" {
  default = "86400"
}

variable "maintenance_page_enabled" {
  default = "false"
}

variable "maintenance_page_content_line_1" {
  default = "The learning website is undergoing scheduled maintenance."
}

variable "maintenance_page_content_line_2" {
  default = "It will be unavailable between the hours of 7pm to 9pm on Wednesday 24th February 2021."
}

variable "maintenance_page_content_line_3" {
  default = "Apologies for the inconvenience."
}

variable "maintenance_page_content_line_4" {
  default = "If the maintenance period is extended, further information will be provided here."
}

variable "backend_api_call_batch_size" {
  default = "50"
}
