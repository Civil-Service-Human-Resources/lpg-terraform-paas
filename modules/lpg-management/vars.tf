variable "lpg_management_name" {
  default = "name"
}

variable "rg_name" {
  default = "holder"
}

variable "rg_prefix" {
  default = "rgpref"
}

variable "rg_location" {
  default = "location"
}

variable "docker_tag" {
  default = ""
}

variable "docker_image" {
  default = "cshr/lpg-services-management-ui"
}

variable "virtual_host" {
  default = "virtual_host"
}

variable "authentication_service_url" {
  default = "http://identity-something.cshr.digital"
}

variable "azure_storage_connection_string" {
  default = "blob_connection_string"
}

variable "xapi_url" {
  default = "xapi_url"
}

variable "environment_tag" {
  default = "unknown"
}
