variable "lpg_ui_name" {
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
  default = "latest"
}

variable "docker_image" {
  default = "cshr/lpg-services-ui"
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

variable "booking_alert_webhook" {
  default = "booking_alert_webhook"
}

variable "google_analytics_id" {
  default = "google_analytics_id"
}

variable "gov_notify_api_key" {
  default = "gov_notify_api_key"
}

variable "learner_record_url" {
  default = "learner_record_url"
}

variable "learner_record_user" {
  default = "learner_record_user"
}

variable "learner_record_pass" {
  default = "learner_record_password"
}

variable "course_catalogue_url" {
  default = "course_catalogue_url"
}

variable "course_catalogue_user" {
  default = "course_catalogue_user"
}

variable "course_catalogue_pass" {
  default = "course_catalogue_pass"
}

variable "environment_tag" {
  default = "unknown"
}

variable "xapi_url" {
  default = "xapi-url"
}

variable "youtube_api_key" {
  default = "youtube_api_key"
}
