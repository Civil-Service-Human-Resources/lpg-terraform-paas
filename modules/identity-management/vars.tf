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

variable "docker_repository" {
  default = "identity-management"
}

variable "docker_repository_region" {
  default = "test"
}

variable "datasource" {
  default = "db_url"
}

variable "websites_port" {
  default = "8081"
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

variable "learner_record_url" {
  default = ""
}

variable "registry_service_url" {
  default = ""
}

variable "notification_service_url" {
  default = ""
}

variable "identity_management_url" {
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