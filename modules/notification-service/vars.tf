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

variable "ai_instrument_key" {
  default = "c79ba178-0bb8-48cd-a7d2-20d73ba59b5d"
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

variable "docker_image" {
  default = "notification-service"
}

variable "envurl" {
  default = "local"
}

variable "env_profile" {
  default = "test"
}

variable "websites_port" {
  default = "9006"
}

variable "hammer_logstash_host" {
  default = "54e2fb5d-be7a-47c2-b3cf-6f72f42b5dfb-ls.logit.io"
}

variable "hammer_logstash_port" {
  default = "16690"
}

variable "hammer_working_directory" {
  default = ""
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