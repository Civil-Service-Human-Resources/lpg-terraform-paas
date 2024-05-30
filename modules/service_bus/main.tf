resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.name
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = "Premium"
  capacity 			  = var.capacity
}

module "queues" {
  for_each = { for queue in var.queues : queue.name => queue}
  source = "../service_bus_queue"
  namespace_id = azurerm_servicebus_namespace.servicebus.id
  name = each.value.name
  create_reader = each.value.create_reader
  create_writer = each.value.create_writer
}