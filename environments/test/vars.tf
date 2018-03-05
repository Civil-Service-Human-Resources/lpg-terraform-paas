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
