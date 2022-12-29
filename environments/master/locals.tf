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
  lpg_ui_ip_blocks = [for idx, ip in data.azurerm_app_service.lpg_ui_data.possible_outbound_ip_address_list : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "lpg_ui_${idx}"
  }]

	lpg_management_ip_blocks = [for idx, ip in data.azurerm_app_service.lpg_management_data.possible_outbound_ip_address_list : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "lpg_management_${idx}"
  }]

    lpg_report_service_ip_blocks = [for idx, ip in data.azurerm_app_service.report_service_data.possible_outbound_ip_address_list : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "lpg_report_service_${idx}"
  }]

    identity_ip_blocks = [for idx, ip in data.azurerm_app_service.identity_data.possible_outbound_ip_address_list : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "identity_${idx}"
  }]

    civil_servant_registry_ip_blocks = [for idx, ip in data.azurerm_app_service.civil_servant_registry_data.possible_outbound_ip_address_list : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "civil_servant_registry_${idx}"
  }]

    learning_catalogue_ip_blocks = [for idx, ip in data.azurerm_app_service.learning_catalogue_data.possible_outbound_ip_address_list : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "learning_catalogue_${idx}"
  }]

    learner_record_ip_blocks = [for idx, ip in data.azurerm_app_service.learner_record_data.possible_outbound_ip_address_list : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "learner_record_${idx}"
  }]

    identity_management_ip_blocks = [for idx, ip in data.azurerm_app_service.identity_management_data.possible_outbound_ip_address_list : {
	ipAddress = "${ip}/32"
	action = "Allow"
	tag = "Default"
	priority = 1
	name = "identity_management_${idx}"
  }]

}

locals {

  csrs_allowed_ip_addresses = concat(local.lpg_ui_ip_blocks,
	local.identity_ip_blocks,
	local.lpg_management_ip_blocks,
	local.learner_record_ip_blocks,
	local.learning_catalogue_ip_blocks,
	local.lpg_report_service_ip_blocks,
	local.identity_management_ip_blocks)

  learner_record_allowed_ip_addresses = concat(local.lpg_ui_ip_blocks,
	local.lpg_management_ip_blocks,
	local.learning_catalogue_ip_blocks,
	local.lpg_report_service_ip_blocks,
	local.identity_management_ip_blocks)

  learning_catalogue_allowed_ip_addresses = concat(local.lpg_ui_ip_blocks,
	local.lpg_management_ip_blocks,
	local.lpg_report_service_ip_blocks,
	local.learner_record_ip_blocks)

  report_service_allowed_ip_addresses = concat(local.lpg_ui_ip_blocks,
	local.lpg_management_ip_blocks,
	local.identity_management_ip_blocks)

  notification_service_allowed_ip_addresses = concat(local.learner_record_ip_blocks)
  
}