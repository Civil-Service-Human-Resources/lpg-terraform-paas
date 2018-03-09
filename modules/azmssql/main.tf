
resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_sql_server" "sqlserv" {
    name                         = "${var.sql_serv_name}"
    resource_group_name          = "${var.rg_name}"
    location                     = "${var.rg_location}"
    version                      = "12.0"
    administrator_login          = "${var.sql_admin}"
    administrator_login_password = "${var.sql_pass}"
}

resource "azurerm_sql_database" "sqldb" {
  name                = "${var.sql_db_name}"
  resource_group_name = "${var.rg_name}"
  location            = "${var.rg_location}"
  server_name         = "${var.sql_serv_name}"

  tags {
    environment = "${var.environment_tag}"
  }
}
/*
resource "azurerm_sql_firewall_rule" "sqlfwrule" {
  name                = "${var.sql_rule_name}"
  resource_group_name = "${var.rg_name}"
  server_name         = "${var.sql_serv_name}"
  count               = "${length(split(",", var.outbound_ips))}"
  start_ip_address    = "${element(split(",", var.outbound_ips), count.index)}"
  end_ip_address      = "${element(split(",", var.outbound_ips), count.index)}"
}
*/