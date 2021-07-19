variable "lpg_report_service_name" {
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

variable "docker_tag" {
  default = "latest"
}

variable "docker_image" {
  default = "lpg-report-service"
}

variable "domain" {
  default = ""
}

variable "websites_port" {
  default = "9004"
}

variable "env_profile" {
  default = "test"
}

variable "learner_record_url" {
  default = ""
}

variable "authentication_service_url" {
  default = ""
}

variable "report_service_client_id" {
  default = ""
}

variable "report_service_client_secret" {
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

variable "docker_registry_server_url" {
  default = ""
}

variable "docker_registry_server_username" {
  default = ""
}

variable "docker_registry_server_password" {
  default = ""
}

variable "registry_service_url" {
  default = ""
}

variable "course_catalogue_url" {
  default = ""
}

variable "report_service_command_line" {
  default = "java -javaagent:/opt/appinsights/applicationinsights-agent-3.0.3.jar -jar /data/app.jar"
}

variable "datasource" {
  default = "db_url"
}

variable "jwt_key" {
  default = ""
}

variable "backend_api_call_batch_size" {
  default = "50"
}
