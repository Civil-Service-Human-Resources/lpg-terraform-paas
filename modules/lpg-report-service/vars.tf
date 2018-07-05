variable "lpg_report_service_name" {
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
  default = "latest"
}

variable "docker_image" {
  default = "cshr/lpg-report-service"
}

variable "websites_port" {
  default = "9004"
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

variable "learner_record_url" {
  default = ""
}

variable "authentication_service_url" {
  default = ""
}

variable "report_service_client_id" {
  default = ""
}

variable "report_service_client_secret" {
  default = ""
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