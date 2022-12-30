variable "civil_servant_registry_name" {
  default = "civil-servant-registry"
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

variable "csrs_capacity" {
  default = "1"
}


variable "docker_tag" {
  default = "latest"
}

variable "docker_repository" {
  default = "civil-servant-registry-service"
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

variable "websites_port" {
  default = "9002"
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

variable "check_token_url" {
  default = ""
}

variable "csrs_client_id" {
  default = ""
}

variable "csrs_client_secret" {
  default = ""
}

variable "gov_notify_api_key" {
  default = ""
}

variable "gov_notify_linemanager_template_id" {
  default = "52052be1-b468-40ad-a161-cb5e4f034d4f"
}

variable "authentication_service_url" {
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

variable "agency_token_max_capacity" {
  default = "1500"
}

variable "agency_token_min_capacity" {
  default = "1"
}
variable "jwt_key" {
  default = ""
}

variable "allowed_ip_addresses" {
	type = set(string)
}