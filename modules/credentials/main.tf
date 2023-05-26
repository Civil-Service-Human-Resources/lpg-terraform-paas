resource "random_string" "username" {
  length           = 16
  special          = false
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%*()-_=+[]{}<>:?"
}

output "username" {
  value = random_string.username.result
}

output "password" {
  value = random_password.password.result
}