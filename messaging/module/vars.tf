variable "env" {
	type = string
	description = "The environment"
}

variable "servicebus_capacity" {
	type = number
	description = "Capacity of the servicebus"
	default = 1
}