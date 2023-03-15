variable "rg_name" {
	type = string
	description = "Resource group for the app service"
}

variable "app_name" {
	type = string
	description = "App service name"
}

variable "sku_name" {
	type = string
	description = "SKU name"
	validation {
	  condition = contains([
		"P1v2", "P2v2", "P3v2", "P1v3", "P2v3", "P3v3"
	  ], var.sku_name)
	  error_message = "SKU name is invalid."
	}
}

variable "horizontal_scale" {
	type = number
	description = "Number of instances"
	validation {
		condition = var.horizontal_scale <= 10
		error_message = "Maximum number of instances is 10."
	}
}

variable "app_command_line" {
	type = string
	description = "The startup command for this application."
}

variable "allowed_ip_addresses" {
	type = set(string)
	description = "A set of IP addresses that are allowed to connect to this application."
}

variable "healthcheck_path_override" {
  type = string
  default = "/health"
}

variable "app_managed_identity_id" {
	type = string
	description = "ID for the global app service user-assigned identity"
}