variable "lpg_learning_catalogue_name" {
  default = "name"
}
variable "ai_instrument_key" {
  default = "c79ba178-0bb8-48cd-a7d2-20d73ba59b5d"
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

variable "docker_image" {
  default = "lpg-learning-catalogue"
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

variable "elasticsearch_uri" {
  default = "elasticsearch_uri"
}

variable "elasticsearch_user" {
  default = "user"
}

variable "elasticsearch_password" {
  default = "password"
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