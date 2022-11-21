###### mysql: General Purpose tier ######

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

  administrator_login          = var.mysql_admin_login
  administrator_login_password = var.mysql_admin_pass
  version                      = "5.7"
  ssl_enforcement_enabled              = true

  tags = {
    environment = var.env_profile
  }
}
