variable "name" {
	type = string
	description = "Name of the service bus resource"
}

variable "rg_location" {
	type = string
	description = "Resource group location"
}

variable "rg_name" {
	type = string
	description = "Resource group name"
}

variable "sku" {
	type = string
	description = "Servicebus SKU"
	default = "Standard"
}

variable "queues" {
	type = list(object({
		name = string
		create_reader = bool
		create_writer = bool
	}))
	description = "Queue objects"
	default = []
}
