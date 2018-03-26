variable "learning_locker_api_server_name" {
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
  default = "d37351bdb964f8789706c1a3e48cff71a8055db23be79e68947035e80cf664b7"
}

variable "docker_image" {
  default = "cshr/lpg-learning-locker"
}

variable "websites_port" {
  default = "8082"
}

variable "mongodb_path" {
  default = "mongo_host"
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

variable "hammer_working_directory" {
  default = "/opt/learning-locker"
}

variable "testing" {
  default = "1"
}
