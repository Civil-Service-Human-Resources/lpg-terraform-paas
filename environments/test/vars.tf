### Gen vars ###
variable "rg_name" {
  type    = "string"
  default = "testlab"
}

variable "rg_prefix" {
  type    = "string"
  default = "lpg"
}

variable "rg_location" {
  type    = "string"
  default = "UK South"
}

variable "environment_tag" {
  type    = "string"
  default = "test"
}

### postgres ###
variable "postgres_name" {
  default = "postgres"
}

variable "postgres_sku_name" {
  default = "PGSQLB50"
}

variable "postgres_sku_capacity" {
  default = 50
}

variable "postgres_sku_tier" {
  default = "Basic"
}

### cosmos ###
variable "cosmos_name" {
  default = "cosmos"
}

variable "cosmos_offer_type" {
  default = "Standard"
}

variable "cosmos_consistency_policy_level" {
  default = "Strong"
}

variable "cosmos_failover_policy_location" {
  default = "West Europe"
}

### wso2 ###
variable "wso2_name" {
  default = "wso2"
}

variable "wso2_docker_image" {
  default = "cshr/lpg-wso2-is"
}

variable "wso2_docker_tag" {
  default = "f6516ec8f4f5bb682806133682a325e5db3c7695"
}

### mailhog ###
variable "mailhog_name" {
  default = "mailhog"
}

### lpg-learner-record ###
variable "lpg_learner_record_name" {
  default = "lpg-learner-record"
}

variable "lpg_learner_record_docker_tag" {
  default = "latest"
}

variable "lpg_learner_record_auth_user" {
  default = "user"
}

variable "lpg_learner_record_auth_password" {
  default = "password"
}

variable "xapi_url" {
  default = "xapi_url"
}

### azmssql ###
variable "sql_serv_name" {
  default = "sqlserver"
}

variable "sql_db_name" {
  default = "sqldb"
}

variable "sql_admin" {
  default = "sqladmin"
}

variable "sql_pass" {
  default = "replaceme!@18"
}

variable "sql_rule_name" {
  default = "firewall-rule-"
}

### learning-locker-general ###
variable "ll_docker_tag" {
  default = "d29392f370a186af9d9338fbe796e7d60c32fcd91bf23824c0fd86b6237fcd96"
}

### learning-locker-xapi ###
variable "lpg_learning_locker_xapi_name" {
  default = "xapi"
}

### learning-locker-worker ###
variable "lpg_learning_locker_worker_name" {
  default = "api-worker"
}

### learning-locker-setup ###
variable "lpg_learning_locker_setup_name" {
  default = "setup"
}

### learning-locker-api-server ###
variable "lpg_learning_locker_api_server_name" {
  default = "api-server"
}

### learning-locker-ui ###
variable "lpg_learning_locker_ui_name" {
  default = "ui"
}

variable "api_host" {
  default = "api_host_here"
}

### lpg-management ###
variable "lpg_management_name" {
  default = "lpg-management-ui"
}

variable "virtual_host" {
  default = "virtual_host"
}

variable "authentication_service_url" {
  default = "auth_service_url"
}

variable "aws_access_key_id" {
  default = "access_key"
}

variable "aws_secret_access_key" {
  default = "access_key"
}

variable "lpg_management_docker_tag" {
  default = "latest"
}

### lpg-ui ###
variable "lpg_ui_name" {
  default = "lpg-ui"
}

variable "course_catalogue_url" {
  default = "course_catalogue_url"
}

variable "course_catalogue_user" {
  default = "user"
}

variable "course_catalogue_pass" {
  default = "password"
}

variable "learner_record_url" {
  default = "learner_record_url"
}

variable "learner_record_user" {
  default = "user"
}

variable "learner_record_pass" {
  default = "password"
}

variable "youtube_api_key" {
  default = "AIzaSyDkapeVQajSishsrZTDmqi4rLRRq3HABrY"
}

variable "gov_notify_api_key" {
  default = ""
}

variable "google_analytics_id" {
  default = "UA-22141655-3"
}

variable "booking_alert_webhook" {
  default = "booking_alert_webhook"
}

### lpg-learning-catalogue ###
variable "lpg_learning_catalogue_name" {
  default = "lpg-learning-catalogue"
}

variable "elasticsearch_host" {
  default = "elasticsearch_host"
}

variable "elasticsearch_port" {
  default = "elasticsearch_port"
}

variable "elasticsearch_cluster" {
  default = "elasticsearch_cluster"
}

variable "learning_catalogue_docker_tag" {
  default = "latest"
}
