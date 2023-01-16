variable "lpg_learning_catalogue_name" {
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

variable "learning_catalogue_capacity" {
  default = "1"
}

variable "docker_tag" {
  default = "latest"
}

variable "docker_repository" {
  default = "lpg-learning-catalogue"
}

variable "docker_repository_region" {
  default = "test"
}

variable "domain" {
  default = ""
}

variable "websites_port" {
  default = "9001"
}

variable "auth_user" {
  default = "user"
}

variable "auth_password" {
  default = "password"
}

variable "elasticsearch_protocol" {
  default = "elasticsearch_protocol"
}

variable "elasticsearch_host" {
  default = "elasticsearch_host"
}

variable "elasticsearch_port" {
  default = "elasticsearch_port"
}

variable "elasticsearch_user" {
  default = "user"
}

variable "elasticsearch_password" {
  default = "password"
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

variable "application_insights_connection_string" {
  default = ""
}

variable "azure_account_key" {
  default = ""
}

variable "azure_account_name" {
  default = "lpgdev"
}

variable "azure_storage_container" {
  default = "lpgdevcontent"
}

variable "oauth_service_url" {
  default = "oauth_service_url"
}

variable "client_id" {
  default = ""
}

variable "client_secret" {
  default = ""
}

variable "learner_record_url" {
  default = ""
}

variable "registry_service_url" {
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

variable "jwt_key" {
  default = ""
}