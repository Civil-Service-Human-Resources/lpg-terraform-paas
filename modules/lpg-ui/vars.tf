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

variable "rg_name_lpg_ui" {
  default = "perf_temp"
}

variable "serviceplan_suffix_lpgui" {
  default = "serviceplantemp2"
}

variable "webapp_sku_tier" {
  default = "Basic"
}

variable "webapp_sku_name" {
  default = "B2"
}

variable "lpg_ui_capacity" {
  default = "1"
}

variable "docker_tag" {
  default = "latest"
}

variable "docker_repository" {
  default = "lpg-services"
}

variable "docker_repository_region" {
  default = "test"
}

variable "domain" {
  default = ""
}

variable "authentication_service_url" {
  default = ""
}

variable "google_analytics_id" {
  default = "google_analytics_id"
}


variable "learner_record_url" {
  default = "learner_record_url"
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

variable "xapi_url" {
  default = "xapi-url"
}

variable "env_profile" {
  default = "test"
}

variable "websites_port" {
  default = "3001"
}

variable "content_url" {
  default = ""
}

variable "vaultresourcegroup" {
  default = ""
}

variable "vaultname" {
  default = ""
}

variable "existingkeyvaultsecretname" {
  default = ""
}

variable "certificatename" {
  default = ""
}

variable "envurl" {
  default = "local"
}



variable "registry_service_url" {
  default = ""
}

variable "lpg_ui_server" {
  default = ""
}

variable "lpg_management_server" {
  default = ""
}

variable "contact_us_email" {
  default = ""
}

variable "uv_threadpool_size" {
  default = "16"
}

variable "redis_host" {
  default = ""
}

variable "redis_password" {
  default = ""
}

variable "redis_port" {
  default = ""
}

variable "org_redis_host" {
  default = ""
}

variable "org_redis_password" {
  default = ""
}

variable "org_redis_port" {
  default = ""
}

variable "org_redis_ttl" {
  default = "604800"
}

variable "docker_registry_server_url" {
  default = ""
}





variable "custom_emails" {
  default = ""
}

variable "scaling_enabled" {
  default = ""
}

variable "ui_server_timeout_ms" {
  default = "235000"
}

variable "ui_static_asset_root" {
  default = ""
}

variable "ui_static_asset_ttl" {
  default = "86400000"
}
