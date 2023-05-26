data "azurerm_linux_web_app" "lpg_ui_data" {
	name = "${var.rg_prefix}-${var.rg_name}-lpg-ui"
	resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "lpg_management_data" {
	name = "${var.rg_prefix}-${var.rg_name}-lpg-management"
	resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "report_service_data" {
	name = "${var.rg_prefix}-${var.rg_name}-lpg-report-service"
	resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "identity_data" {
	name = "${var.rg_prefix}-${var.rg_name}-identity"
	resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "civil_servant_registry_data" {
	name = "${var.rg_prefix}-${var.rg_name}-civil-servant-registry"
	resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "learning_catalogue_data" {
	name = "${var.rg_prefix}-${var.rg_name}-lpg-learning-catalogue"
	resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "learner_record_data" {
	name = "${var.rg_prefix}-${var.rg_name}-lpg-learner-record"
	resource_group_name = var.rg_name
}

data "azurerm_linux_web_app" "identity_management_data" {
	name = "${var.rg_prefix}-${var.rg_name}-identity-management"
	resource_group_name = var.rg_name
}

locals {
  	lpg_ui_ips = data.azurerm_linux_web_app.lpg_ui_data.possible_outbound_ip_address_list
	lpg_management_ips = data.azurerm_linux_web_app.lpg_management_data.possible_outbound_ip_address_list
    lpg_report_service_ips = data.azurerm_linux_web_app.report_service_data.possible_outbound_ip_address_list
    identity_ips = data.azurerm_linux_web_app.identity_data.possible_outbound_ip_address_list
    civil_servant_registry_ips = data.azurerm_linux_web_app.civil_servant_registry_data.possible_outbound_ip_address_list
    learning_catalogue_ips = data.azurerm_linux_web_app.learning_catalogue_data.possible_outbound_ip_address_list
    learner_record_ips = data.azurerm_linux_web_app.learner_record_data.possible_outbound_ip_address_list
    identity_management_ips = data.azurerm_linux_web_app.identity_management_data.possible_outbound_ip_address_list
	allowed_ips = toset(concat(
		local.lpg_ui_ips,
		local.lpg_management_ips,
		local.lpg_report_service_ips,
		local.identity_ips,
		local.civil_servant_registry_ips,
		local.learning_catalogue_ips,
		local.learner_record_ips,
		local.identity_management_ips
	))
}
