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

variable "environment_tag" {
  default = "unknown"
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
