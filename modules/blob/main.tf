###### blob ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_storage_account" "blobsa" {
  name                     = "${var.storage_account_name}"
  resource_group_name      = "${var.rg_name}"
  location                 = "${var.storage_account_location}"
  account_tier             = "${var.storage_account_tier}"
  account_replication_type = "${var.storage_account_replication}"
  depends_on               = ["azurerm_resource_group.rg"]

  tags {
    environment = "${var.env_profile}"
  }
}

resource "azurerm_storage_container" "blobc" {
  name                  = "${var.container_name}"
  resource_group_name   = "${var.rg_name}"
  storage_account_name  = "${var.storage_account_name}"
  container_access_type = "${var.container_accesstype}"
  depends_on            = ["azurerm_storage_account.blobsa"]
}

output "storage_connection_string" {
  value = "${azurerm_storage_account.blobsa.primary_connection_string}"
}
