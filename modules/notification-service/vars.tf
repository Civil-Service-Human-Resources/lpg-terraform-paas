variable "notification_service_name" {
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

variable "notification_capacity" {
  default = "1" 
}

variable "docker_tag" {
  default = ""
}

variable "docker_repository" {
  default = "notification-service"
}

variable "docker_repository_region" {
  default = "test"
}

variable "envurl" {
  default = "local"
}



variable "env_profile" {
  default = "test"
}

variable "websites_port" {
  default = "9006"
}

variable "authentication_service_url" {
  default = ""
}

variable "docker_registry_server_url" {
  default = ""
}







variable "allowed_ip_addresses" {
	type = set(string)
}