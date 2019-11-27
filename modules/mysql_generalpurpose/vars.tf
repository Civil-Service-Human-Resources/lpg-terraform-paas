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
  default = "mysql-gp"
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

variable "lpg_gp_skumname"{
    default = "GP_Gen5_8"
}

variable "lpg_gp_capacity"{
    default = 8
}
   
variable "lpg_gp_tier"{
    default = "GeneralPurpose"
}
    
variable "lpg_gp_family"{
    default="Gen5"
}

variable "mysql_storage" {
     default = "51200"
}