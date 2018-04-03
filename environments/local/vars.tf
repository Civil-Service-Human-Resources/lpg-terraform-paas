### Gen vars ###
variable "rg_name" {
  type    = "string"
  default = "lpg-local"
}

variable "rg_prefix" {
  type    = "string"
  default = "lpg"
}

variable "rg_location" {
  type    = "string"
  default = "UK South"
}

variable "lpg_ui_url" {
  default = "http://lpg.local.cshr.digital:3001"
}

variable "lpg_management_ui_url" {
  default = "http://lpg.local.cshr.digital:3003"
}

variable "hammer_api_worker_http_server_port" {
  default = "8080"
}

variable "hammer_logstash_host" {
  default = "54e2fb5d-be7a-47c2-b3cf-6f72f42b5dfb-ls.logit.io"
}

variable "hammer_logstash_port" {
  default = "16690"
}

variable "env_profile" {
  default = "localwso2"
}

### docker tags ###
variable "wso2_docker_tag" {
  default = "0a3168c832991fd4575a35ba816a417ecc154eb2-v2"
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

### wso2 ###
variable "wso2_name" {
  default = "wso2"
}

variable "wso2_docker_image" {
  default = "cshr/lpg-wso2-is"
}
