variable "lpg_ui_name" {
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
  default = "B2"
}

variable "docker_tag" {
  default = "latest"
}

variable "docker_image" {
  default = "lpg-services"
}

variable "authentication_service_url" {
  default = "http://identity-something.cshr.digital"
}

variable "azure_storage_connection_string" {
  default = "blob_connection_string"
}

variable "google_analytics_id" {
  default = "google_analytics_id"
}

variable "gov_notify_api_key" {
  default = "gov_notify_api_key"
}

variable "learner_record_url" {
  default = "learner_record_url"
}

variable "course_catalogue_url" {
  default = "course_catalogue_url"
}

variable "xapi_url" {
  default = "xapi-url"
}

variable "youtube_api_key" {
  default = "youtube_api_key"
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

variable "websites_port" {
  default = "3001"
}

variable "session_secret" {
  default = ""
}

variable "hammer_working_directory" {
  default = ""
}

variable "content_url" {
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
  default = "local"
}

variable "registry_service_url" {
  default = ""
}

variable "lpg_ui_server" {
  default = ""
}

variable "lpg_ui_oauth_client_id" {
  default = ""
}

variable "lpg_ui_oauth_client_secret" {
  default = ""
}

variable "lpg_management_server" {
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
