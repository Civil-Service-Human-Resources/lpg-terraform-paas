variable "identity_name" {
  default = "identity"
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

variable "docker_repository" {
  default = "identity-service"
}

variable "docker_repository_region" {
  default = "test"
}

variable "domain" {
  default = ""
}

variable "datasource" {
  default = "db_url"
}

variable "asset_cdn" {
  default = ""
}

variable "websites_port" {
  default = "8080"
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

variable "registry_service_url" {
  default = ""
}

variable "jwt_key" {
  default = ""
}
variable "invite_validity" {
  default = "259200"
}
variable "duration_after_rereg_allowed_seconds" {
  default = "86400"
}

variable "maintenance_page_enabled" {
  default = "false"
}

variable "maintenance_page_content_line_1" {
  default = "The learning website is undergoing scheduled maintenance."
}

variable "maintenance_page_content_line_2" {
  default = "It will be unavailable between the hours of 7pm to 9pm on Wednesday 24th February 2021."
}

variable "maintenance_page_content_line_3" {
  default = "Apologies for the inconvenience."
}

variable "maintenance_page_content_line_4" {
  default = "If the maintenance period is extended, further information will be provided here."
}

variable "identity_base_url" {
  default = ""
}

variable "email_template_url" {
  default = ""
}

variable "encryption_key" {
  default = ""
}