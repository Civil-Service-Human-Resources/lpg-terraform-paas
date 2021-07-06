variable "lpg_management_name" {
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

variable "lpg_management_capacity" {
  default = "1"
}

variable "docker_tag" {
  default = ""
}

variable "docker_image" {
  default = "lpg-management-ui"
}

variable "domain" {
  default = ""
}

variable "request_timeout_ms" {
  default = "60000"
}

variable "authentication_service_url" {
  default = ""
}

variable "server_timeout_ms" {
  default = "235000"
}

variable "authentication_service_timeout_ms" {
  default = "60000"
}

variable "env_profile" {
  default = "test"
}

variable "websites_port" {
  default = "3001"
}

variable "session_secret" {
  default = ""
}

variable "envurl" {
  default = "local"
}

variable "application_insights_connection_string" {
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

variable "lpg_management2_server" {
  default = ""
}

variable "lpg_management_oauth_client_id" {
  default = ""
}

variable "lpg_management_oauth_client_secret" {
  default = ""
}

variable "callback_url" {
  default = ""
}

variable "lpg_ui_url" {
  default = ""
}

variable "report_service_url" {
  default = ""
}

variable "report_service_timeout_ms" {
  default = "235000"
}

variable "course_catalogue_url" {
  default = "course_catalogue_url"
}

variable "course_catalogue_timeout_ms" {
  default = "60000"
}

variable "course_catalogue_user" {
  default = "course_catalogue_user"
}

variable "course_catalogue_pass" {
  default = "course_catalogue_pass"
}

variable "content_url" {
  default = ""
}

variable "youtube_api_key" {
  default = ""
}

variable "youtube_timeout_ms" {
  default = "60000"
}

variable "registry_service_url" {
  default = ""
}

variable "registry_service_timeout_ms" {
  default = "60000"
}

variable "learner_record_url" {
  default = ""
}

variable "learner_record_timeout_ms" {
  default = "60000"
}

variable "redis_host" {
  default = ""
}

variable "redis_password" {
  default = ""
}

variable "redis_port" {
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