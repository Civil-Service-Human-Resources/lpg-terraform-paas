variable "identity_management_name" {
  default = "identity_management"
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
  default = "identity-service"
}

variable "datasource" {
  default = "db_url"
}

variable "websites_port" {
  default = "8081"
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


variable "authentication_service_url" {
  default = ""
}
variable "identity_management_client_id" {
  default = ""
}

variable "identity_management_client_secret" {
  default = ""
}

variable "invite_signup_url" {
  default = ""
}

variable "learner_record_url" {
  default = ""
}

variable "registry_service_url" {
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
