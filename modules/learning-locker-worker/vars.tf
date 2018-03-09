variable "learning_locker_worker_name" {
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
  default = "cshr/lpg-learning-locker"
}
variable "mongo_url" {
  default = "mongo_url"
}
variable "mongodb_path" {
  default = "mongo_host"
}
variable "redis_host" {
  default = "hostname"
}
variable "redis_url" {
  default = "url"
}