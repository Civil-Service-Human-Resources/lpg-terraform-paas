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

variable "docker_image" {
	type = string
	description = "(optional) describe your variable"
}

variable "docker_tag" {
	type = string
	description = "(optional) describe your variable"
}

variable "domain" {
	type = string
	description = "(optional) describe your variable"
}

variable "certificate_keyvault_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "certificate_keyvault_name_rg" {
	type = string
	description = "(optional) describe your variable"
}

variable "certificate_name" {
	type = string
	description = "(optional) describe your variable"
}

# variable "secret_keyvault_name_rg" {
# 	type = string
# 	description = "(optional) describe your variable"
# }

# variable "secret_keyvault_name" {
# 	type = string
# 	description = "(optional) describe your variable"
# }
