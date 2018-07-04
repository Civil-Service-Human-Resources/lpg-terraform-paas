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

variable "docker_tag" {
  default = "latest"
}

variable "docker_image" {
  default = "cshr/civil-servant-registry-service"
}

variable "datasource" {
  default = "db_url"
}

variable "websites_port" {
  default = "9002"
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