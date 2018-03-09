variable "rg_name" {
  default = "holder"
}
variable "rg_prefix" {
  default = "rgpref"
}
variable "rg_location" {
  default = "location"
}
variable "sql_serv_name" {
  default = "sqlname"
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
variable "environment_tag" {
  default = "unknown"
}
variable "sql_rule_name" {
  default = "firewall-rule-"
}
variable "outbound_ips" {
  type = "string"
  default = "0.0.0.0"
}
variable "start_ip" {
  default = "0.0.0.0/32"
}
variable "end_ip" {
  default = "0.0.0.0/32"
}