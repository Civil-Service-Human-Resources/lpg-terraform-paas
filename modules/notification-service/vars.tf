variable "notification_service_name" {
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

variable "notification_capacity" {
  default = "1" 
}

variable "docker_tag" {
  default = ""
}

variable "docker_repository" {
  default = "notification-service"
}

variable "docker_repository_region" {
  default = "test"
}

variable "envurl" {
  default = "local"
}

variable "application_insights_connection_string" {
  default = ""
}

variable "env_profile" {
  default = "test"
}

variable "websites_port" {
  default = "9006"
}

variable "gov_notify_api_key" {
  default = ""
}

variable "authentication_service_url" {
  default = ""
}

variable "notification_service_client_id" {
  default = ""
}

variable "notification_service_client_secret" {
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

variable "jwt_key" {
  default = ""
}