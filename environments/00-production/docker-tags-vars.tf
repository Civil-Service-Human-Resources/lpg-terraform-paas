variable "civil_servant_registry_docker_tag" {
  default = "idt-release-7.0-1-20210722-145923"
}

variable "identity_docker_tag" {
  default = "idt-release-7.0-1-20210722-145741"
}

variable "identity_management_docker_tag" {
  default = "idt-release-5.0-1"
}

variable "ll_docker_tag" {
  default = "fe8104bf2f0fedb8f5af138bd8860a9c27dd2bb12ecb827f09e754e279a70fa8"
}

variable "lpg_learner_record_docker_tag" {
  default = "idt-release-7.0-1-20210722-145741"
}

variable "learning_catalogue_docker_tag" {
  default = "idt-release-7.0-2-20210722-150339"
}

variable "lpg_management_tag" {
  default = "idt-release-7.0-1-20210722-144948"
}

variable "lpg_report_service_docker_tag" {
  default = "idt-release-7.0-1-20210722-150049"
}

## lpg-services ##

variable "lpg_services_docker_repository_region" {
  default = "prod"
}

variable "lpg_services_tag" {
  default = "v1.1.0"
}

variable "notification_service_tag" {
  default = "idt-release-7.0-1-20210722-145922"
}

variable "data_transchiver_tag" {
  default = "master-12"
}