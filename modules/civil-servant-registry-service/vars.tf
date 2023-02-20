variable "allowed_ip_addresses" {
	type = set(string)
	description = "A set of IP addresses that are allowed to connect to this application."
}

variable "civil_servant_registry_name" {
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

variable "csrs_capacity" {
	type = string
	description = "(optional) describe your variable"
}

variable "env_profile" {
	type = string
	description = "(optional) describe your variable"
}

variable "custom_emails" {
	type = string
	default = ""
	description = "(optional) describe your variable"
}

variable "scaling_enabled" {
	type = string
	description = "(optional) describe your variable"
}