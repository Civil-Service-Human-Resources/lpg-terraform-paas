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
  default = "cshr/lpg-services"
}

variable "virtual_host" {
  default = "virtual_host"
}

variable "authentication_service_url" {
  default = "http://identity-something.cshr.digital"
}

variable "aws_access_key_id" {
  default = "access_key"
}

variable "aws_secret_access_key" {
  default = "secret_key"
}

variable "xapi_url" {
  default = "xapi_url"
}

variable "environment_tag" {
  default = "unknown"
}
