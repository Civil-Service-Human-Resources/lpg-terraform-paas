resource "azurerm_servicebus_queue" "servicebus_queue" {
  name         = var.name
  namespace_id = var.namespace_id

  enable_partitioning = true
}

resource "azurerm_servicebus_queue_authorization_rule" "reader" {
  count = (var.create_reader == true) ? 1 : 0
  name     = "reader"
  queue_id = azurerm_servicebus_queue.servicebus_queue.id

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "writer" {
  count = (var.create_writer == true) ? 1 : 0
  name     = "writer"
  queue_id = azurerm_servicebus_queue.servicebus_queue.id

  listen = false
  send   = true
  manage = false
}