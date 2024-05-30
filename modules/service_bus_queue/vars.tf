variable "name" {
	type = string
	description = "Name of the service bus resource"
}

variable "namespace_id" {
	type = string
	description = "Service bus namespace ID"
}

variable "create_reader" {
	type = bool
	description = "Create a reader key?"
}

variable "create_writer" {
	type = bool
	description = "Create a writer key?"
}
