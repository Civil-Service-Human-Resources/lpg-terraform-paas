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

variable "docker_tag" {
  default = ""
}

variable "docker_image" {
  default = "cshr/lpg-learning-locker"
}

variable "mongo_url" {
  default = "mongo_url"
}

variable "mongodb_path" {
  default = "mongo_host"
}

variable "redis_host" {
  default = "hostname"
}

variable "redis_url" {
  default = "url"
}

variable "api_host" {
  default = "api_host"
}

variable "virtual_host" {
  default = "lrs-somthing.cshr.digital"
}

variable "virtual_port" {
  default = "3000"
}

variable "websites_port" {
  default = "3000"
}

variable "letsencrypt_host" {
  default = "lrs-somthing.cshr.digital"
}

variable "letsencrypt_email" {
  default = "email@address.com"
}

variable "environment_tag" {
  default = "unknown"
}
