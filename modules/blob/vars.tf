variable "rg_name" {
  default = "holder"
}
variable "rg_prefix" {
  default = "rgpref"
}
variable "rg_location" {
  default = "location"
}
variable "storage_account_name" {
  default = "lpgpackages"
}
variable "storage_account_location" {
  default = "uksouth"
}
variable "storage_account_tier" {
  default = "Standard"
}
variable "storage_account_replication" {
  default = "LRS"
}
variable "container_name" {
  default = "packages"
}
variable "container_accesstype" {
  default = "private"
}
variable "env_profile" {
  default = ""
}