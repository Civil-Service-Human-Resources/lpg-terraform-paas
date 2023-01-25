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

variable "replication" {
	type = string
	description = "(optional) describe your variable"
}

variable "containers" {
	type = set(string)
	description = "(optional) describe your variable"
}
