###### mysql: General Purpose tier ######

resource "random_string" "username" {
  length           = 16
  special          = true
  override_special = "-"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%*()-_=+[]{}<>:?"
}

resource "azurerm_mysql_server" "lpg_gp" {
  name                = var.mysql_name
  location            = var.mysql_location
  resource_group_name = var.rg_name

  create_mode = "Default"

  sku_name = var.lpg_gp_skumname

  storage_mb = var.mysql_storage
  backup_retention_days = 30
  geo_redundant_backup_enabled = false
  auto_grow_enabled = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"

  threat_detection_policy {
    disabled_alerts = []
    email_account_admins = false
    email_addresses = []
    enabled = true
    retention_days = 0
  }

  administrator_login          = random_string.username.result
  administrator_login_password = random_password.password.result

  # This block ensures that once a random US/PW is used to create the mysql instance,
  # TF won't edit it again afterwards.
  lifecycle {
	ignore_changes = [
	  administrator_login,
	  administrator_login_password
	]
  }

  version                      = "5.7"
  ssl_enforcement_enabled              = true

  tags = {
    environment = var.env_profile
  }
}
