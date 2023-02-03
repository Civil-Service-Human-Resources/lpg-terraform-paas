module "credentials" {
  source = "../credentials"
}

resource "azurerm_mysql_flexible_server" "example" {
  name                   = var.name
  resource_group_name    = var.rg_name
  location               = var.location
  
  version = "8.0.21"

  backup_retention_days  = 30
  sku_name               = var.sku

  administrator_login          = module.credentials.username
  administrator_password = module.credentials.password

  # This block ensures that once a random US/PW is used to create the mysql instance,
  # TF won't edit it again afterwards.
  lifecycle {
	ignore_changes = [
	  administrator_login,
	  administrator_password
	]
  }

  zone = 1

  storage {
	auto_grow_enabled = true
	size_gb = var.size_in_gb
  }  
}