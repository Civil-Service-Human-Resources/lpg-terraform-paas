variable "lpg_learner_record_name" {
  default = "name"
}

variable "rg_name" {
  default = "holder"
}

variable "rg_prefix" {
  default = "rgpref"
}

variable "rg_location" {
  default = "location"
}

variable "webapp_sku_tier" {
  default = "Basic"
}

variable "webapp_sku_name" {
  default = "B1"
}

variable "learner_record_capacity" {
  default = "1"
}

variable "datasource" {
  default = "db_url"
}

variable "docker_tag" {
  default = "latest"
}

variable "docker_repository" {
  default = "lpg-learner-record"
}

variable "docker_repository_region" {
  default = "test"
}

variable "domain" {
  default = ""
}

variable "websites_port" {
  default = "9000"
}

variable "env_profile" {
  default = "test"
}

variable "authentication_service_url" {
  default = ""
}

variable "learner_record_client_id" {
  default = ""
}

variable "learner_record_client_secret" {
  default = ""
}

variable "registry_service_url" {
  default = ""
}

variable "course_catalogue_url" {
  default = ""
}

variable "gov_notify_api_key" {
  default = ""
}

variable "required_learning_template_id" {
  default = ""
}

variable "complete_learning_template_id" {
  default = ""
}

variable "vaultresourcegroup" {
  default = ""
}

variable "vaultname" {
  default = ""
}

variable "existingkeyvaultsecretname" {
  default = ""
}

variable "certificatename" {
  default = ""
}

variable "envurl" {
  default = ""
}

variable "application_insights_connection_string" {
  default = ""
}

variable "spring_profiles_active" {
  default = "default"
}

variable "lpg_ui_url" {
  default = ""
}

variable "notification_service_url" {
  default = ""
}

variable "docker_registry_server_url" {
  default = ""
}

variable "docker_registry_server_username" {
  default = ""
}

variable "docker_registry_server_password" {
  default = ""
}

variable "custom_emails" {
  default = ""
}

variable "scaling_enabled" {
  default = ""
}

variable "cosmos_connection_string" {
  default = ""
}

variable "learner_record_command_line" {
  default = "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "jwt_key" {
  default = ""
}

variable "completed_job_cron" {
  default = "0 0 4 * * *"
}

variable "incomplete_job_cron" {
  default = "0 30 5 * * *"
}

variable "completed_job_enabled" {
  default = "true"
}

variable "incompleted_job_enabled" {
  default = "true"
}

variable "allowed_ip_addresses" {
	type = list(object({
		ipAddress = string
		action = string
		tag = string
		priority = number
		name = string
	}))
}