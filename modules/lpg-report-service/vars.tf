variable "allowed_ip_addresses" {
	type = set(string)
	description = "A set of IP addresses that are allowed to connect to this application."
}

variable "lpg_report_service_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "rg_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "vaultresourcegroup" {
	type = string
	description = "(optional) describe your variable"
}

variable "vaultname" {
	type = string
	description = "(optional) describe your variable"
}

variable "existingkeyvaultsecretname" {
	type = string
	description = "(optional) describe your variable"
}

variable "certificatename" {
	type = string
	description = "(optional) describe your variable"
}

variable "domain" {
	type = string
	description = "(optional) describe your variable"
}

variable "envurl" {
	type = string
	description = "(optional) describe your variable"
}

variable "webapp_sku_tier" {
	type = string
	description = "(optional) describe your variable"
}

variable "webapp_sku_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "env_profile" {
	type = string
	description = "(optional) describe your variable"
}

variable "report_service_command_line" {
	type = string
	description = "(optional) describe your variable"
}
