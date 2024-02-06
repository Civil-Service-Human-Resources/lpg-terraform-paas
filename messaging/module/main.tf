resource "azurerm_resource_group" "messaging_rg" {
  name = "rg-messaging-${var.env}"
  location = "UKSouth"
}

module "reporting_service_bus" {
  source = "../../modules/service_bus"
  name = "sb-reporting-${var.env}"
  queues = [
	{
		name = "courseCompletions",
		create_reader = true,
		create_writer = true
	}
  ]
  rg_name = azurerm_resource_group.messaging_rg.name
  rg_location = azurerm_resource_group.messaging_rg.location
}