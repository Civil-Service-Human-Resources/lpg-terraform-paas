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

variable "docker_tag" {
  default = "latest"
}

variable "docker_image" {
  default = "cshr/lpg-learning-catalogue"
}

variable "websites_port" {
  default = "9001"
}

variable "authentication_service_url" {
  default = ""
}

variable "lpg_learning_catalogue_oauth_client_id" {
  default = ""
}

variable "lpg_learning_catalogue_oauth_client_secret" {
  default = ""
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