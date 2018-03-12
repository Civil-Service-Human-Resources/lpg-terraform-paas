variable "mailhog_name" {
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

variable "docker_image" {
  default = "mailhog/mailhog"
}

variable "websites_port" {
  default = "8025"
}

variable "environment_tag" {
  default = "unknown"
}
