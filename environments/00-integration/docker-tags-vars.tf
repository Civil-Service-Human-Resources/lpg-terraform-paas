## csrs ##

variable "civil_servant_registry_docker_tag" {
  default = "master"
}

variable "civil_servant_registry_docker_repository_region" {
  default = "test"
}

## identity ##

variable "identity_docker_tag" {
  default = "idt-develop"
}

variable "identity_docker_repository_region" {
  default = "test"
}

## identity-management ##

variable "identity_management_docker_tag" {
  default = "master"
}

variable "identity_management_docker_repository_region" {
  default = "test"
}

## learning-locker ##

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

## learner-record ##

variable "lpg_learner_record_docker_tag" {
  default = "master"
}

variable "lpg_learner_record_docker_repository_region" {
  default = "test"
}

## learning-catalogue ##

variable "learning_catalogue_docker_tag" {
  default = "master"
}

variable "learning_catalogue_docker_repository_region" {
  default = "test"
}

## lpg-management ##

variable "lpg_management_tag" {
  default = "master"
}

variable "lpg_management_docker_repository_region" {
  default = "test"
}

## report-service ## 

variable "lpg_report_service_docker_tag" {
  default = "master"
}

variable "lpg_report_service_docker_repository_region" {
  default = "test"
}

## lpg-services ##

variable "lpg_services_docker_repository_region" {
  default = "test"
}

variable "lpg_services_tag" {
  default = "idt-feature-LC-1094-update-servicedesk-email"
}

## notification-service ##

variable "notification_service_tag" {
  default = "master"
}

variable "notification_service_docker_repository_region" {
  default = "test"
}

## data-transchiver ##

variable "data_transchiver_tag" {
  default = "master-12"
}