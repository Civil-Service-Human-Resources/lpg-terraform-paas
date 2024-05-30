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
		condition = var.horizontal_scale <= 15
		error_message = "Maximum number of instances is 15."
	}
}

variable "app_command_line" {
	type = string
	description = "The startup command for this application."
}

variable "healthcheck_path_override" {
  type = string
  default = "/health"
}

variable "app_managed_identity_id" {
	type = string
	description = "ID for the global app service user-assigned identity"
}

variable "frontdoor_enabled" {
	type = bool
	description = "Should this web app be served via Azure Frontdoor"
	default = false
}

variable "use_legacy_name" {
	type = bool
	description = "Use the legacy naming convention (lpg-{resource_group}-app_name)"
	default = false
}

variable "serviceplan_suffix" {
	type = string
	description = "Suffix for the serviceplan name - only used by lpg UI in production"
	default = ""
}

variable "restrict_ips" {
	type = bool
	description = "Should incoming IP address rules be applied"
	default = true
}