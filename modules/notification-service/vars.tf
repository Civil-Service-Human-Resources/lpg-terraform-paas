variable "allowed_ip_addresses" {
	type = set(string)
	description = "A set of IP addresses that are allowed to connect to this application."
}

variable "notification_service_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "rg_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "env_profile" {
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

variable "notification_capacity" {
	type = string
	description = "(optional) describe your variable"
}
