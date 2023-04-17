### Gen vars ###

variable "subscription_name" {
	type = string
	description = "Subscription to apply the update to"
	default = "CSL-Staging"
}

variable "rg_name" {
  type    = string
  default = "lpgperf"
}

variable "rg_name_lpg_ui" {
  type = string
  default = "perf_temp"
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
  default = "serviceplantemp2"
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
  default = "performance.learn.civilservice.gov.uk"
}

variable "scaling_enabled" {
  default = "false"
}

variable "env_profile" {
  default = "perf"
}

variable "google_analytics_id" {
  default = "UA-22141655-7"
}

### redis ###

variable "redis_session_capacity" {
  default = "1"
}

variable "redis_org_capacity" {
  default = "1"
}

variable "redis_csl_service_capacity" {
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
  default = "https://asset-cdn.performance.learn.civilservice.gov.uk"
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

variable "spring_profiles_active" {
  default = "test,production"
}

### identity-management ###

variable "identity_management_data_retention_cron_schedule" {
  default = "0 0 5 * * *"
}

variable "identity_management_data_retention_enabled" {
  default = "true"
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
  default = "lpgdevcontent"
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

variable "identity_base_url" {
  default = "https://identity.performance.learn.civilservice.gov.uk"
}

variable "vaultresourcegroup" {
  default = "lpg-prod-keyvault"
}

variable "vaultname" {
  default = "lpg-prod-kv"
}

variable "existingkeyvaultsecretname" {
	default = "star-performance-learn-civil-service-gov-uk-2023"
}

variable "certificatename" {
	default = "star-performance-learn-civilservice-gov-uk-2023"
}

variable "ui_existingkeyvaultsecretname" {
	default = "star-performance-learn-civil-service-gov-uk-2023"
}

variable "ui_certificatename" {
	default = "star-performance-learn-civilservice-gov-uk-2023"
}

variable "custom_emails" {
  default = "pritpalp@kainos.com"
}

## CSL-Service ##

variable "csl_service_vertical_scale" {
	type = string
	default = "P1v2"
}

variable "csl_service_horizontal_scale" {
	type = number
	default = 1
}

## Rustici ##

variable "rustici_engine_vertical_scale" {
	type = string
	description = "(optional) describe your variable"
	default = "P1v2"
}

variable "rustici_engine_horizontal_scale" {
	type = string
	description = "(optional) describe your variable"
	default = 1
}

variable "rustici_mysql_size_gb" {
	type = string
	description = "(optional) describe your variable"
	default = 20
}

variable "rustici_mysql_sku" {
	type = string
	description = "(optional) describe your variable"
	default = "GP_Standard_D2ds_v4"
}

## APP COMMAND LINES ##

variable "learner_record_app_command_line" {
	type = string
	default = "java -Xms1g -Xmx2g -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "identity_app_command_line" {
	type = string
	default = "java -Xms1g -Xmx2g -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "report_service_app_command_line" {
	type = string
	default = "java -Xms1g -Xmx2g -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "learning_catalogue_app_command_line" {
	type = string
	default = "java -Xms1g -Xmx2g -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "civil_servant_registry_app_command_line" {
	type = string
	default = "java -Xms1g -Xmx2g -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "notification_service_app_command_line" {
	type = string
	default = "java -Xms1g -Xmx2g -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "csl_service_app_command_line" {
	type = string
	default = "java -Xms1g -Xmx2g -javaagent:/opt/appinsights/applicationinsights-agent-3.4.4.jar -jar /data/app.jar"
}