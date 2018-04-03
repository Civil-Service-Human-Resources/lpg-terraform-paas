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

variable "docker_tag" {
  default = "docker_tag"
}

variable "docker_image" {
  default = "cshr/lpg-learning-catalogue"
}

variable "websites_port" {
  default = "9001"
}

variable "auth_user" {
  default = "user"
}

variable "auth_password" {
  default = "password"
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
