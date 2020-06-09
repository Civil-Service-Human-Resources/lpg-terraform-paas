variable "identity_name" {
  default = "identity"
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

variable "serviceplan_suffix" {
  default = "serviceplan"
}

variable "webapp_sku_tier" {
  default = "Basic"
}

variable "webapp_sku_name" {
  default = "B1"
}

variable "identity_capacity" {
  default = "1"
}

variable "docker_tag" {
  default = "latest"
}

variable "docker_image" {
  default = "identity-service"
}

variable "domain" {
  default = ""
}

variable "datasource" {
  default = "db_url"
}

variable "websites_port" {
  default = "8080"
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

variable "gov_notify_api_key" {
  default = ""
}

variable "gov_notify_invite_template_id" {
  default = ""
}

variable "gov_notify_reset_template_id" {
  default = ""
}

variable "gov_notify_reset_successful_template_id" {
  default = ""
}

variable "invite_signup_url" {
  default = ""
}

variable "reset_url" {
  default = ""
}

variable "lpg_ui_url" {
  default = ""
}

variable "whitelisted_domains" {
  default = ""
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

variable "custom_emails" {
  default = ""
}

variable "scaling_enabled" {
  default = ""
}

variable "authentication_service_url" {
  default = ""
}

variable "jwt_key" {
  default = ""
}