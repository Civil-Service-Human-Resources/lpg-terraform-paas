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

variable "postgres_user" {
  default = ""
}

variable "postgres_pass" {
  default = ""
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
  default = "0b7e83825f49740c091ade17ce231587071dd327"
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

### learning-locker-general ###
variable "ll_docker_tag" {
  default = "d29392f370a186af9d9338fbe796e7d60c32fcd91bf23824c0fd86b6237fcd96"
}

### learning-locker-xapi ###
variable "lpg_learning_locker_xapi_name" {
  default = "xapi"
}

variable "ll_xapi_docker_tag" {
  default = "7e6b19d6d8bf99ce9d4c322b449a6744b7a33c23071e653bef827d0277b83441"
}

### learning-locker-worker ###
variable "lpg_learning_locker_worker_name" {
  default = "api-worker"
}

variable "ll_api_worker_docker_tag" {
  default = "cd954f2c7cf423ce3c20223e4e3e73899246b96f9efdecc84770ac6b77d0ffe1"
}

### learning-locker-setup ###
variable "lpg_learning_locker_setup_name" {
  default = "setup"
}

variable "ll_setup_docker_tag" {
  default = "fc53b8729e706154b33f384081e0f3664d7ad9e7d8a3e9ddb3fd21e9dd10e556"
}

### learning-locker-api-server ###
variable "lpg_learning_locker_api_server_name" {
  default = "api-server"
}

variable "ll_api_server_docker_tag" {
  default = "988cb07eb553b13d90ea7a48d9da247ca74c74b8b3a0e5e91f837976b2a0fb3b"
}

### learning-locker-ui ###
variable "lpg_learning_locker_ui_name" {
  default = "ui"
}

variable "ll_ui_docker_tag" {
  default = "b5cddb229c58e961b96b4566e99e8971ac2b56ee31189f14e7b510b029be89ee"
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
