terraform {
  required_version = "~> 0.13.0"
  backend "azurerm" {
    storage_account_name = "lpgterraformsecure"
    container_name       = "tfstatesecure"
    key                  = "staging-messaging.terraform.tfstate"
	resource_group_name = "lpgterraform"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=3.6.0"
    }
  }
}

provider "azurerm" {
  subscription_id = module.subscription.subscription_id
  features {} 
}

