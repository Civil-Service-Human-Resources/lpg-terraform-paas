variable "subscription_name" {
	type = string
	description = "Subscription to apply the update to"
	default = "CSL-Staging"
}

variable "rg_name" {
	default = "lpgintegration"
}

variable "rg_name_lpg_ui" {
	default =  "lpgintegration"
}

variable "rg_prefix" {
	default =  "lpg"
}

variable "rg_location" {
	default =  "UK South"
}

variable "serviceplan_suffix" {
	default =  "serviceplan"
}

variable "serviceplan_suffix_lpgui" {
	default =  "serviceplan"
}

variable "webapp_sku_tier" {
	default =  "Basic"
}

variable "webapp_sku_tier_p2" {
	default =  "PremiumV2"
}

variable "webapp_sku_name_1" {
	default =  "B1"
}

variable "webapp_sku_name_2" {
	default =  "B2"
}

variable "webapp_sku_name_3" {
	default =  "B3"
}

variable "webapp_sku_name_p1" {
	default =  "P1v2"
}

variable "webapp_sku_name_p2" {
	default =  "P1v2"
}

variable "webapp_sku_name_p3" {
	default =  "P1v2"
}

variable "identity_capacity" {
	default =  "2"
}

variable "csrs_capacity" {
	default =  "1"
}

variable "xapi_capacity" {
	default =  "1"
}

variable "learner_record_capacity" {
	default =  "1"
}

variable "learning_catalogue_capacity" {
	default =  "1"
}

variable "lpg_ui_capacity" {
	default =  "2"
}

variable "notification_capacity" {
	default =  "1"
}

variable "lpg_management_capacity" {
	default =  "1"
}

variable "envurl" {
	default =  ""
}

variable "domain" {
	default =  "integration.learn.civilservice.gov.uk"
}

variable "scaling_enabled" {
	default =  "false"
}

variable "env_profile" {
	default =  "integration"
}

variable "google_analytics_id" {
	default =  "UA-22141655-3"
}

variable "cosmos_name" {
	default =  "cosmos"
}

variable "cosmos_offer_type" {
	default =  "Standard"
}

variable "cosmos_consistency_policy_level" {
	default =  "Strong"
}

variable "cosmos_failover_policy_location" {
	default =  "West Europe"
}

variable "redis_queue_provider" {
	default =  "REDIS"
}

variable "redis_queue_namespace" {
	default =  "learninglocker"
}

variable "redis_prefix" {
	default =  "learninglocker"
}

variable "redis_use_tls" {
	default =  "1"
}

variable "redis_capacity" {
	default =  "0"
}

variable "redis_session_capacity" {
	default =  "0"
}

variable "redis_org_capacity" {
	default =  "0"
}

variable "identity_name" {
	default =  "identity"
}

variable "lpg_learner_record_name" {
	default =  "lpg-learner-record"
}

variable "lpg_learner_record_websites_port" {
	default =  "9000"
}

variable "learner_record_command_line" {
	default =  "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "lpg_testing" {
	default =  "1"
}

variable "lpg_learning_locker_xapi_name" {
	default =  "learning-locker-xapi"
}

variable "ll_xapi_express_port" {
	default =  "8083"
}

variable "lpg_learning_locker_worker_name" {
	default =  "learning-locker-api-worker"
}

variable "worker_api_env_app" {
	default =  "learning-locker-api-worker"
}

variable "lpg_learning_locker_ui_name" {
	default =  "learning-locker-ui"
}

variable "lpg_learning_locker_api_port" {
	default =  "8082"
}

variable "ll_ui_port" {
	default =  "80"
}

variable "lpg_ui_name" {
	default =  "lpg-ui"
}

variable "ui_websites_port" {
	default =  "3001"
}

variable "ui_server_timeout_ms" {
	default =  "235000"
}

variable "ui_static_asset_ttl" {
	default =  "86400000"
}

variable "ui_static_asset_root" {
	default =  "https://asset-cdn.integration.learn.civilservice.gov.uk"
}

variable "lpg_learning_catalogue_name" {
	default =  "lpg-learning-catalogue"
}

variable "azure_account_name" {
	default =  "lpgdev"
}

variable "mysql_name_gp" {
	default =  "gp"
}

variable "mysql_name_ll" {
	default =  "ll"
}

variable "mysql_storage" {
	default =  "4194304"
}

variable "civil_servant_registry_name" {
	default =  "civil-servant-registry"
}

variable "agency_token_max_capacity" {
	default =  "5000"
}

variable "agency_token_min_capacity" {
	default =  "1"
}

variable "lpg_report_service_name" {
	default =  "lpg-report-service"
}

variable "report_service_websites_port" {
	default =  "9004"
}

variable "report_service_command_line" {
	default =  "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "spring_profiles_active" {
	default =  "test,production"
}

variable "identity_management_data_retention_cron_schedule" {
	default =  "0 0 5 * * *"
}

variable "identity_management_data_retention_enabled" {
	default =  "true"### lpg-management ###
}

variable "lpg_management_name" {
	default =  "lpg-management"
}

variable "lpg_management_websites_port" {
	default =  "3005"
}

variable "content_container" {
	default =  "lpgdevcontent"
}

variable "lpg_management_report_service_timeout_ms" {
	default =  "235000"
}

variable "lpg_management_request_timeout_ms" {
	default =  "60000"
}

variable "lpg_management_server_timeout_ms" {
	default =  "235000"
}

variable "lpg_management_authentication_service_timeout_ms" {
	default =  "60000"
}

variable "lpg_management_youtube_timeout_ms" {
	default =  "60000"
}

variable "lpg_management_course_catalogue_timeout_ms" {
	default =  "60000"
}

variable "lpg_management_learner_record_timeout_ms" {
	default =  "60000"
}

variable "lpg_management_civil_servant_registry_service_timeout_ms" {
	default =  "60000"
}

variable "notification_service_name" {
	default =  "notification-service"
}

variable "data_transchiver_name" {
	default =  "lpg-data-transchriver"
}

variable "job_schedule" {
	default =  "0 1 21 * * *"
}

variable "invite_validity" {
	default =  "259200"
}

variable "duration_after_rereg_allowed_seconds" {
	default =  "86400"
}

variable "backend_api_call_batch_size" {
	default =  "50"
}

variable "identity_base_url" {
	default =  "https://identity.integration.learn.civilservice.gov.uk"
}

variable "vaultresourcegroup" {
	default = "lpg-prod-keyvault"
}

variable "vaultname" {
	default = "lpg-prod-kv"
}

variable "custom_emails" {
	default = "robertm@kainos.com"
}

variable "docker_registry_server_url" {
	default = "lpgregistry.azurecr.io"
}

variable "existingkeyvaultsecretname" {
	default = "star-integration-learn-civil-service-gov-uk-pfxsecret-2022"
}

variable "certificatename" {
	default = "star-integration-learn-civil-service-gov-uk-2022"
}

variable "ui_existingkeyvaultsecretname" {
	default = "star-integration-learn-civil-service-gov-uk-pfxsecret-2022"
}

variable "ui_certificatename" {
	default = "star-integration-learn-civil-service-gov-uk-2022"
}

variable "identity_management_name" {
	default = "identity-management"
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

variable keyvault_users_group_object_id {
	type="string"
	default = ""
}