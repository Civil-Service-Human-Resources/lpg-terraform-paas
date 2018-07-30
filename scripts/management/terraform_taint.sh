#!/bin/bash -e

#terraform untaint -state=state.tf -module=redis azurerm_redis_cache.redis_cache
#terraform taint -state=state.tf -module=redis azurerm_redis_cache.redis_cache

env=$1
module=$2

cd ../../environments/$1

resource=$( terraform show -module-depth=1 | grep module.${module} | tr -d ':' | sed -e 's/module.'"${module}"'.//' )

for r in resource; do
    terraform taint -state=state.tf -module=${module} ${resource}
done