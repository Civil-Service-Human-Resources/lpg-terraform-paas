variable "name" {
	type = string
	description = "(optional) describe your variable"
}

variable "rg_name" {
	type = string
	description = "(optional) describe your variable"
}

variable "location" {
	type = string
	description = "(optional) describe your variable"
}

variable "sku" {
	type = string
	description = "(optional) describe your variable"
	validation {
	  condition = contains([
		"GP_Standard_D2ds_v4",
		"GP_Standard_D4ds_v4",
		"GP_Standard_D8ds_v4",
		"GP_Standard_D16ds_v4",
		"GP_Standard_D32ds_v4",
		"GP_Standard_D48ds_v4",
		"GP_Standard_D64ds_v4"
	  ], var.sku)
	  error_message = "Invalid SKU."
	}
}

variable "size_in_gb" {
	type = string
	description = "(optional) describe your variable"
}

variable "databases" {
	type = set(string)
	description = "(optional) describe your variable"
}
