terraform {
  required_providers {
	azurerm = {
		version = "=3.6.0"
	}
	azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.7.0"
    }
  }
}