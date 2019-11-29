variable "data_transchiver_name" {
  default = "name"
}
variable "ai_instrument_key" {
  default = "c79ba178-0bb8-48cd-a7d2-20d73ba59b5d"
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
  default = "data-transchriver"
}

variable "env_profile" {
  default = "test"
}

variable "websites_port" {
  default = "8080"
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

variable "tds_mysql_proc_registry_host" {
  default = ""
}

variable "tds_mysql_proc_registry_db_user" {
  default = ""
}

variable "tds_mysql_proc_registry_db_pwd" {
  default = ""
}

variable "tds_mysql_learner_record_db_host" {
  default = ""
}

variable "tds_mysql_learner_record_db_user" {
  default = ""
}

variable "tds_mysql_learner_record_db_pwd" {
  default = ""
}

variable "tds_mysql_history_db_host" {
  default = ""
}

variable "tds_mysql_history_db_user" {
  default = ""
}

variable "tds_mysql_history_db_pwd" {
  default = ""
}

variable "cosmos_src_connection_string" {
  default = ""
}

variable "data_xfr_job_schedule" {
  default = ""
}
