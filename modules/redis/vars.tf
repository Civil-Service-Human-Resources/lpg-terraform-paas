variable "rg_name" {
  default = "holder"
}

variable "rg_prefix" {
  default = "rgpref"
}

variable "rg_location" {
  default = "location"
}

variable "redis_name" {
  default = "name"
}

variable "redis_capacity" {
  default = "0"
}

variable "redis_family" {
  default = "C"
}

variable "redis_enable_non_ssl_port" {
  default = "true"
}

variable "redis_max_clients" {
  default = "2000"
}

variable "redis_maxmemory_reserved" {
  default = "2"
}

variable "redis_maxmemory_delta" {
  default = "2"
}

variable "redis_maxmemory_policy" {
  default = "volatile-lru"
}

variable "env_profile" {
  default = ""
}
