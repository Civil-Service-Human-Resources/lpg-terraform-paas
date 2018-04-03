variable "rg_name" {
  default = "holder"
}
variable "rg_prefix" {
  default = "rgpref"
}
variable "rg_location" {
  default = "location"
}
variable "postgres_location" {
  default = "West Europe"
}
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
variable "postgres_admin_login" {
  default = ""
}
variable "postgres_admin_pass" {
  default = ""
}
variable "postgres_version" {
  default = "9.6"
}
variable "postgres_storage_mb" {
  default = "51200"
}
variable "postgres_ssl_enforcement" {
  default = "Enabled"
}
variable "env_profile" {
  default = ""
}
