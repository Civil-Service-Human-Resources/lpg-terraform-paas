data "azurerm_subscriptions" "available" {
	display_name_contains = var.subscription_name
}

output "subscription_id" {
  value = data.azurerm_subscriptions.available.subscriptions[0].subscription_id
}