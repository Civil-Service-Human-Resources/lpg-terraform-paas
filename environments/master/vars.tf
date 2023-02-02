### Gen vars ###
variable "rg_name" {
  type    = string
  default = ""
}

variable "rg_name_lpg_ui" {
  type = string
  default = ""
}

variable "rg_prefix" {
  type    = string
  default = ""
}

variable "rg_location" {
  type    = string
  default = ""
}

variable "serviceplan_suffix" {
  type = string
  default = ""
}

variable "serviceplan_suffix_lpgui" {
  type = string
  default = ""
}

variable "webapp_sku_tier" {
  default = ""
}

variable "webapp_sku_tier_p2" {
  default = ""
}

variable "webapp_sku_name_1" {
  default = ""
}

variable "webapp_sku_name_2" {
  default = ""
}

variable "webapp_sku_name_3" {
  default = ""
}

variable "webapp_sku_name_p1" {
  default = ""
}

variable "webapp_sku_name_p2" {
  default = ""
}

variable "webapp_sku_name_p3" {
  default = ""
}

variable "identity_capacity" {
  default = ""
}

variable "csrs_capacity" {
  default = ""
}

variable "xapi_capacity" {
  default = ""
}

variable "learner_record_capacity" {
  default = ""
}

variable "learning_catalogue_capacity" {
  default = ""
}

variable "lpg_ui_capacity" {
  default = ""
}

variable "notification_capacity" {
  default = ""
}

variable "lpg_management_capacity" {
  default = ""
}

variable "envurl" {
  default = ""
}

variable "domain" {
  default = ""
}

variable "scaling_enabled" {
  default = ""
}

variable "env_profile" {
  default = ""
}

variable "google_analytics_id" {
  default = ""
}

### cosmos ###
variable "cosmos_name" {
  default = ""
}

variable "cosmos_offer_type" {
  default = ""
}

variable "cosmos_consistency_policy_level" {
  default = ""
}

variable "cosmos_failover_policy_location" {
  default = ""
}

### redis ###
variable "redis_queue_provider" {
  default = ""
}

variable "redis_queue_namespace" {
  default = ""
}

variable "redis_prefix" {
  default = ""
}

variable "redis_use_tls" {
  default = ""
}

variable "redis_capacity" {
  default = ""
}

variable "redis_session_capacity" {
  default = ""
}

variable "redis_org_capacity" {
  default = ""
}

### identity ###
variable "identity_name" {
  default = ""
}

### lpg-learner-record ###
variable "lpg_learner_record_name" {
  default = ""
}

variable "lpg_learner_record_websites_port" {
  default = ""
}

variable "learner_record_command_line" {
  default = ""
}

### learning-locker-general ###
variable "lpg_testing" {
  default = ""
}

### learning-locker-xapi ###
variable "lpg_learning_locker_xapi_name" {
  default = ""
}

variable "ll_xapi_express_port" {
  default = ""
}

### learning-locker-worker ###
variable "lpg_learning_locker_worker_name" {
  default = ""
}

variable "worker_api_env_app" {
  default = ""
}

### learning-locker-ui ###
variable "lpg_learning_locker_ui_name" {
  default = ""
}

variable "lpg_learning_locker_api_port" {
  default = ""
}

variable "ll_ui_port" {
  default = ""
}

### lpg-ui ###
variable "lpg_ui_name" {
  default = ""
}

variable "ui_websites_port" {
  default = ""
}

variable "ui_server_timeout_ms" {
  default = ""
}

variable "ui_static_asset_ttl" {
  default = ""
}

variable "ui_static_asset_root" {
  default = ""
}

### lpg-learning-catalogue ###
variable "lpg_learning_catalogue_name" {
  default = ""
}

variable "azure_account_name" {
  default = ""
}

### mysql_gp ###
variable "mysql_name_gp" {
  default = ""
}

variable "mysql_user" {
  default = ""
}

variable "mysql_pass" {
  default = ""
}

variable "mysql_pass_ll" {
  default = ""
}

### mysql_ll ###
variable "mysql_name_ll" {
  default = ""
}

variable "mysql_storage" {
  default = ""
}

### civil-servant-registry ###
variable "civil_servant_registry_name" {
  default = ""
}

variable "agency_token_max_capacity" {
  default = ""
}

variable "agency_token_min_capacity" {
  default = ""
}

variable "lpg_report_service_name" {
  default = ""
}

variable "report_service_websites_port" {
  default = ""
}

variable "report_service_command_line" {
  default = ""
}

variable "spring_profiles_active" {
  default = ""
}

### identity-management ###

variable "identity_management_name" {
  default = ""
}

variable "identity_management_data_retention_cron_schedule" {
  default = ""
}

variable "identity_management_data_retention_enabled" {
  default = ""
}


### lpg-management ###
variable "lpg_management_name" {
  default = ""
}

variable "lpg_management_websites_port" {
  default = ""
}

variable "content_container" {
  default = ""
}

variable "lpg_management_report_service_timeout_ms" {
  default = ""
}

variable "lpg_management_request_timeout_ms" {
  default = ""
}

variable "lpg_management_server_timeout_ms" {
  default = ""
}

variable "lpg_management_authentication_service_timeout_ms" {
  default = ""
}

variable "lpg_management_youtube_timeout_ms" {
  default = ""
}

variable "lpg_management_course_catalogue_timeout_ms" {
  default = ""
}

variable "lpg_management_learner_record_timeout_ms" {
  default = ""
}

variable "lpg_management_civil_servant_registry_service_timeout_ms" {
  default = ""
}

### notification-service ###
variable "notification_service_name" {
  default = ""
}

### data-transchriver ###ß
variable "data_transchiver_name" {
  default = ""
}

variable "job_schedule" {
  default = ""
}
variable "invite_validity" {
  default = ""
}
variable "duration_after_rereg_allowed_seconds" {
  default = ""
}

variable "backend_api_call_batch_size" {
  default = ""
}

variable "identity_base_url" {
  default = ""
}

variable "identity_docker_tag" {
  default = ""
}

variable "identity_docker_repository_region"{
  default = ""
}

variable "vaultresourcegroup" {
  default = ""
}

variable "vaultname" {
  default = ""
}

variable "custom_emails" {
  default = ""
}

variable "docker_registry_server_url" {
  default = ""
}

variable "identity_management_docker_tag" {
  default = ""
}

variable "identity_management_docker_repository_region" {
  default = ""
}

variable "lpg_learner_record_docker_tag" {
  default = ""
}

variable "lpg_learner_record_docker_repository_region" {
  default = ""
}

variable "lpg_report_service_docker_tag" {
  default = ""
}

variable "lpg_report_service_docker_repository_region" {
  default = ""
}

variable "ll_docker_tag" {
  default = ""
}

variable "lpg_services_docker_repository_region" {
  default = ""
}

variable "lpg_services_tag" {
  default = ""
}

variable "learning_catalogue_docker_tag" {
  default = ""
}

variable "learning_catalogue_docker_repository_region" {
  default = ""
}

variable "civil_servant_registry_docker_tag" {
  default = ""
}

variable "civil_servant_registry_docker_repository_region" {
  default = ""
}

variable "lpg_management_tag" {
  default = ""
}

variable "lpg_management_docker_repository_region" {
  default = ""
}

variable "notification_service_tag" {
  default = ""
}

variable "notification_service_docker_repository_region" {
  default = ""
}

variable "data_transchiver_tag" {
  default = ""
}

variable "existingkeyvaultsecretname" {
  default = ""
}

variable "certificatename" {
  default = ""
}

variable "ui_existingkeyvaultsecretname" {
  default = ""
}