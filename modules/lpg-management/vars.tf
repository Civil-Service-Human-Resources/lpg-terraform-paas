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

variable "docker_tag" {
  default = ""
}

variable "docker_image" {
  default = "cshr/lpg-services"
}

variable "authentication_service_url" {
  default = "http://identity-something.cshr.digital"
}

variable "azure_storage_connection_string" {
  default = "blob_connection_string"
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

variable "youtube_api_key" {
  default = ""
}

variable "hammer_working_directory" {
  default = ""
}

variable "lpg_ui_server" {
  default = ""
}

variable "course_catalogue_url" {
  default = "url"
}

variable "course_catalogue_user" {
  default = "user"
}

variable "course_catalogue_pass" {
  default = "password"
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

variable "lpg_management_server" {
  default = ""
}

variable "registry_service_url" {
  default = ""
}

variable "lpg_management_oauth_client_id" {
  default = ""
}

variable "lpg_management_oauth_client_secret" {
  default = ""
}