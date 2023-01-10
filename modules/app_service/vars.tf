variable "rg_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "app_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "sku_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "horizontal_scale" {
	type = number
	description = "(optional) describe your variable"
}

variable "app_command_line" {
	type = string
	description = "(optional) describe your variable"
}

variable "allowed_ip_addresses" {
	type = set(string)
	description = "(optional) describe your variable"
}

variable "domain" {
	type = string
	description = "(optional) describe your variable"
}


variable "certificate_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "certificate_kv_id" {
	type = string
	description = "(optional) describe your variable"
}

variable "secret_kv_id" {
	type = string
	description = "(optional) describe your variable"
}

