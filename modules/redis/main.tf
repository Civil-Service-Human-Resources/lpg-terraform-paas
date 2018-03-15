###### redis ######

resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.rg_location}"
}

resource "azurerm_redis_cache" "redis_cache" {
  name                = "${var.redis_name}"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  capacity            = "${var.redis_capacity}"
  family              = "${var.redis_family}"
  sku_name            = "${var.redis_sku_name}"
  enable_non_ssl_port = "${var.redis_enable_non_ssl_port}"
  shard_count         = "${var.redis_shard_count}"

  redis_configuration {
    maxclients         = "${var.redis_max_clients}"
    maxmemory_reserved = "${var.redis_maxmemory_reserved}"
    maxmemory_delta    = "${var.redis_maxmemory_delta}"
    maxmemory_policy   = "${var.redis_maxmemory_policy}"
  }
}

output "redis_key" {
  value = "${azurerm_redis_cache.redis_cache.primary_access_key}"
}

output "redis_host" {
  value = "${azurerm_redis_cache.redis_cache.hostname}"
}

output "redis_port" {
  value = "${azurerm_redis_cache.redis_cache.ssl_port}"
}
