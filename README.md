# LPG Terraform for Azure PaaS

## Prerequisite

### Create or symlink (if it exists) the state.tf file for the environment you want to deploy.

**storage_account_name** is the resource group name (e.g. *myterraformstates*)

**container_name** is the blob container name (e.g. *states*)

**key** is the name of terraform state (e.g. *mystate.terraform.tfstate*)

**access_key** is the storage account access key
 
```
terraform {
  backend "azurerm" {
    storage_account_name  = ""
    container_name        = ""
    key                   = ""
    access_key            = ""
  }
}
``` 

## Commands

Authenticate with Azure:

``` az login ```

To install provider: 

```terraform init```

Select environment/workspace dev|test|prod to deploy to:

``` terraform plan ```

``` terrraform apply ```

Or to bypass the confirmation prompt:

``` terrraform apply -auto-approve ```
