variable "learning_locker_xapi_name" {
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

variable "docker_tag" {
  default = "latest"
}

variable "docker_image" {
  default = "lpg-learning-locker"
}

variable "domain" {
  default = ""
}

variable "websites_port" {
  default = "8083"
}

variable "mongo_url" {
  default = "mongo_url"
}

variable "redis_url" {
  default = "url"
}

variable "express_port" {
  default = "8083"
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

variable "redis_prefix" {
  default = "learninglocker"
}

variable "redis_use_tls" {
  default = "1"
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

variable "custom_emails" {
  default = ""
}

variable "scaling_enabled" {
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
