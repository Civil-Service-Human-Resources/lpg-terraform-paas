variable "learning_locker_ui_name" {
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

variable "mongodb_path" {
  default = "mongo_host"
}

variable "api_host" {
  default = "api_host"
}

variable "api_port" {
  default = "80"
}

variable "websites_port" {
  default = "3000"
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

variable "testing" {
  default = "1"
}

variable "ui_host" {
  default = "this_server"
}

variable "ui_port" {
  default = "80"
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
