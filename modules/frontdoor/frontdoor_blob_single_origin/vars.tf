variable "name" {
	type = string
	description = "(optional) describe your variable"
}

variable "frontdoor_profile_id" {
	type = string
	description = "(optional) describe your variable"
}

variable "blob_storage_fqdn" {
	type = string
	description = "(optional) describe your variable"
}

variable "endpoint_id" {
	type = string
	description = "(optional) describe your variable"
}

variable "cdn_paths" {
	type = set(string)
	description = "(optional) describe your variable"
}

variable "blob_container" {
	type = string
	description = "(optional) describe your variable"
}

variable "custom_domain_id" {
	type = string
	description = "(optional) describe your variable"
}
