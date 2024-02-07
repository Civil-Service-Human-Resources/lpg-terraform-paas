#!/bin/bash -e

MODULE_NAME=$1
mkdir $MODULE_NAME
cd $MODULE_NAME
mkdir -p module
touch module/main.tf module/vars.tf module/state.tf

echo "terraform {
  required_providers {
	azurerm = {
		version = \"=3.6.0\"
	}
  }
}" >> module/state.tf

backend_conf="terraform {
  required_version = \"~> 0.13.0\"
  backend \"azurerm\" {
    storage_account_name = \"lpgterraformsecure\"
    container_name       = \"tfstatesecure\"
    key                  = \"int-devops.terraform.tfstate\"
	resource_group_name = "lpgterraform"
  }

  required_providers {
    azurerm = {
      source = \"hashicorp/azurerm\"
      version = \"=3.6.0\"
    }
  }
}

provider \"azurerm\" {
  subscription_id = module.subscription.subscription_id
  features {} 
}"

for env in integration staging performance production
do
	mkdir -p $env
	touch $env/main.tf $env/state.tf
	echo "terraform {
		required_version = \"~> 0.13.0\"
		backend \"azurerm\" {
			storage_account_name = \"lpgterraformsecure\"
			container_name       = \"tfstatesecure\"
			key                  = \"${env}-${MODULE_NAME}.terraform.tfstate\"
			resource_group_name = "lpgterraform"
		}

		required_providers {
			azurerm = {
			source = \"hashicorp/azurerm\"
			version = \"=3.6.0\"
			}
		}
	}

		provider \"azurerm\" {
		subscription_id = module.subscription.subscription_id
		features {} 
	}" >> $env/state.tf
	case "$env" in
		integration) sub="Staging" ;;
		staging) sub="Staging" ;;
		performance) sub="Staging" ;;
		*) sub="Production" ;;
	esac
	subscription=
	echo "module \"subscription\" {
			source = \"../../modules/subscription\"
			subscription_name = \"CSL-${sub}\"
		}

		module \"env\" {
			source = \"../module\"
		}" >> $env/main.tf
done