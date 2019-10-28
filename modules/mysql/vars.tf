variable "rg_name" {
  default = "holder"
}
variable "rg_prefix" {
  default = "rgpref"
}
variable "rg_location" {
  default = "location"
}
variable "mysql_location" {
  default = "West Europe"
}
variable "mysql_name" {
  default = "mysql"
}
variable "env_profile" {
  default = ""
}
variable "mysql_admin_login" {
  default = ""
}
variable "mysql_admin_pass" {
  default = ""
}
variable "lpg_skumname"{
    default = "B_Gen5_2"
}

variable "lpg_capacity"{
    default = 2
}
   
variable "lpg_tier"{
    default = "Basic"
}

variable "lpg_family"{
    default="Gen5"
}