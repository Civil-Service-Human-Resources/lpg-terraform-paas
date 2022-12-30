data "azurerm_app_service" "lpg_ui_data" {
	name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_ui_name}"
	resource_group_name = var.rg_name_lpg_ui
}

data "azurerm_app_service" "lpg_management_data" {
	name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_management_name}"
	resource_group_name = var.rg_name
}

data "azurerm_app_service" "report_service_data" {
	name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_report_service_name}"
	resource_group_name = var.rg_name
}

data "azurerm_app_service" "identity_data" {
	name = "${var.rg_prefix}-${var.rg_name}-${var.identity_name}"
	resource_group_name = var.rg_name
}

data "azurerm_app_service" "civil_servant_registry_data" {
	name = "${var.rg_prefix}-${var.rg_name}-${var.civil_servant_registry_name}"
	resource_group_name = var.rg_name
}

data "azurerm_app_service" "learning_catalogue_data" {
	name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learning_catalogue_name}"
	resource_group_name = var.rg_name
}

data "azurerm_app_service" "learner_record_data" {
	name = "${var.rg_prefix}-${var.rg_name}-${var.lpg_learner_record_name}"
	resource_group_name = var.rg_name
}

data "azurerm_app_service" "identity_management_data" {
	name = "${var.rg_prefix}-${var.rg_name}-${var.identity_management_name}"
	resource_group_name = var.rg_name
}

locals {
  	lpg_ui_ips = data.azurerm_app_service.lpg_ui_data.possible_outbound_ip_address_list
	lpg_management_ips = data.azurerm_app_service.lpg_management_data.possible_outbound_ip_address_list
    lpg_report_service_ips = data.azurerm_app_service.report_service_data.possible_outbound_ip_address_list
    identity_ips = data.azurerm_app_service.identity_data.possible_outbound_ip_address_list
    civil_servant_registry_ips = data.azurerm_app_service.civil_servant_registry_data.possible_outbound_ip_address_list
    learning_catalogue_ips = data.azurerm_app_service.learning_catalogue_data.possible_outbound_ip_address_list
    learner_record_ips = data.azurerm_app_service.learner_record_data.possible_outbound_ip_address_list
    identity_management_ips = data.azurerm_app_service.identity_management_data.possible_outbound_ip_address_list

}

locals {

  csrs_allowed_ip_addresses = toset(concat(local.lpg_ui_ips,
	local.identity_ips,
	local.lpg_management_ips,
	local.learner_record_ips,
	local.learning_catalogue_ips,
	local.lpg_report_service_ips,
	local.identity_management_ips))

  learner_record_allowed_ip_addresses = toset(concat(local.lpg_ui_ips,
	local.lpg_management_ips,
	local.learning_catalogue_ips,
	local.lpg_report_service_ips,
	local.identity_management_ips))

  learning_catalogue_allowed_ip_addresses = toset(concat(local.lpg_ui_ips,
	local.lpg_management_ips,
	local.lpg_report_service_ips,
	local.learner_record_ips))

  report_service_allowed_ip_addresses = toset(concat(local.lpg_ui_ips,
	local.lpg_management_ips,
	local.identity_management_ips))

  notification_service_allowed_ip_addresses = toset(concat(local.learner_record_ips))
  
}