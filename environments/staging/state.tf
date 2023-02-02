terraform {
  required_version = "~> 0.13.0"
  backend "azurerm" {
    storage_account_name  = "lpgterraformsecure"
    container_name        = "tfstatesecure"
    key                   = "00-staging.terraform.tfstate"
  }
}

provider "azurerm" {
  version = ">=3.0.0"

  features {} 
  subscription_id = module.subscription.subscription_id
}

