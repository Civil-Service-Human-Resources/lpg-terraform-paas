variable "lpg_learner_record_name" {
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

variable "datasource" {
  default = "db_url"
}

variable "docker_image" {
  default = "cshr/lpg-learner-record"
}

variable "websites_port" {
  default = "9000"
}

variable "xapi_url" {
  default = "xapi_url"
}

variable "xapi_username" {
  default = "66f2b4fc001e3da992d23b57d8a7457655bea078"
}

variable "xapi_password" {
  default = "1c0e1b6827606d7efed71e204939d048f94f842b"
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

variable "authentication_service_url" {
  default = ""
}

variable "learner_record_client_id" {
  default = ""
}

variable "learner_record_client_secret" {
  default = ""
}

variable "registry_service_url" {
  default = ""
}

variable "course_catalogue_url" {
  default = ""
}

variable "course_catalogue_user" {
  default = ""
}

variable "course_catalogue_pass" {
  default = ""
}

variable "gov_notify_api_key" {
  default = ""
}

variable "required_learning_template_id" {
  default = ""
}

variable "complete_learning_template_id" {
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

variable "spring_profiles_active" {
  default = "default"
}