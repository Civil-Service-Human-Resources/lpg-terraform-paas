### Gen vars ###
variable "rg_name" {
  type 		= "string"
  default 	= "testlab"
}
variable "rg_prefix" {
  type    = "string"
  default = "lpg"
}
variable "rg_location" {
  type    = "string"
  default = "UK South"
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

### ws02 ###
variable "wso2_name" {
  default = "wso2"
}
variable "lpg_ui_url" {
  default = "lpq_ui_url"
}
variable "app_service_sku" {
  default = "Standard"
}
variable "app_service_sku_code" {
  default = "S1"
}
variable "app_service_worker_size" {
  default = "1"
}
variable "wso2_docker_image" {
  default = "cshr/lpg-wso2-is"
}
variable "wso2_docker_tag" {
  default = "1b21c10238616ef442b86c36364f28791d97d550"
}

### mailhog ###
variable "mailhog_name" {
  default = "mailhog"
}