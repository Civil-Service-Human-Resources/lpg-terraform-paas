variable "name" {
	type = string
	description = "Resource name"
}

variable "rg_name" {
	type = string
	description = "Resource group name"
}

variable "location" {
	type = string
	description = "Location"
}

variable "sku" {
	type = string
	description = "SKU"
}

variable "size_in_mb" {
	type = number
	description = "Size in megabytes"
}

variable "databases" {
	type = set(string)
	description = "list of databases"
}
