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
  default = "mysql8-gp"
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

variable "lpg_gp_skuname"{
    default = "GP_Standard_D2ds_v4"
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
     default = "52"
}