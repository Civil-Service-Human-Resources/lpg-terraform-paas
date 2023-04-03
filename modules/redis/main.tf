###### redis ######

resource "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  capacity            = var.redis_capacity
  family              = var.redis_family
  sku_name            = var.redis_sku_name
  enable_non_ssl_port = var.redis_enable_non_ssl_port
  minimum_tls_version = "1.0"
  
  redis_configuration {
    maxmemory_reserved = var.redis_maxmemory_reserved
    maxmemory_delta    = var.redis_maxmemory_delta
    maxmemory_policy   = var.redis_maxmemory_policy
  }

  tags = {
    environment = var.env_profile
  }
}

resource "azurerm_redis_firewall_rule" "example" {
	for_each 			= var.allowed_ips
	name                = replace(each.value, ".", "_")
	redis_cache_name    = azurerm_redis_cache.redis_cache.name
	resource_group_name = var.rg_name
	start_ip            = each.value
	end_ip              = each.value
}

output "redis_key" {
  value = azurerm_redis_cache.redis_cache.primary_access_key
}

output "redis_host" {
  value = azurerm_redis_cache.redis_cache.hostname
}

output "redis_port" {
  value = azurerm_redis_cache.redis_cache.ssl_port
}
