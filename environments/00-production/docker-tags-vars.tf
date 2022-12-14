## csrs ##

variable "civil_servant_registry_docker_tag" {
  default = "v1.2.0"
}

variable "civil_servant_registry_docker_repository_region" {
  default = "prod"
}

## identity ##

variable "identity_docker_tag" {
  default = "v1.4.0"
}

variable "identity_docker_repository_region" {
  default = "prod"
}

## identity-management ##

variable "identity_management_docker_tag" {
  default = "v1.0.0"
}

variable "identity_management_docker_repository_region" {
  default = "prod"
}

## learning-locker ##

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

## learner-record ##

variable "lpg_learner_record_docker_tag" {
  default = "v1.2.0"
}

variable "lpg_learner_record_docker_repository_region" {
  default = "prod"
}

## learning-catalogue ##

variable "learning_catalogue_docker_tag" {
  default = "v1.2.0"
}

variable "learning_catalogue_docker_repository_region" {
  default = "prod"
}

## lpg-management ##

variable "lpg_management_tag" {
  default = "v1.4.0"
}

variable "lpg_management_docker_repository_region" {
  default = "prod"
}

## report-service ## 

variable "lpg_report_service_docker_tag" {
  default = "v1.1.0"
}

variable "lpg_report_service_docker_repository_region" {
  default = "prod"
}

## lpg-services ##

variable "lpg_services_docker_repository_region" {
  default = "prod"
}

variable "lpg_services_tag" {
  default = "v1.6.0"
}

## notification-service ##

variable "notification_service_tag" {
  default = "v1.1.0"
}

variable "notification_service_docker_repository_region" {
  default = "prod"
}

## data transchiver ##

variable "data_transchiver_tag" {
  default = "master-12"
}
