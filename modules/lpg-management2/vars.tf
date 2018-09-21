variable "lpg_management2_name" {
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
  default = ""
}

variable "docker_image" {
  default = "lpg-management-ui"
}

variable "authentication_service_url" {
  default = ""
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

variable "hammer_working_directory" {
  default = ""
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

variable "lpg_management2_oauth_client_id" {
  default = ""
}

variable "lpg_management2_oauth_client_secret" {
  default = ""
}

variable "callback_url" {
  default = ""
}

variable "lpg_ui_url" {
  default = ""
}

variable "course_catalogue_url" {
  default = "course_catalogue_url"
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

variable "docker_registry_server_url" {
  default = ""
}

variable "docker_registry_server_username" {
  default = ""
}

variable "docker_registry_server_password" {
  default = ""
}
