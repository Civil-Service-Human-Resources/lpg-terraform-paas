# LPG Terraform

### Dependencies

In order to run the code in this repository, the following should be installed on the environment that is being used

#### Core binaries

- Terraform v0.13.0 (as of writing)
- Azure CLI v2.10.1 (as of writing)

#### Access / Permissions

- Azure Account for LPG

------------

### Azure Access

For non-Production environments, a Service Principal is used which will grant access to Terraform in order to run State consistency checks and deployments.

If deploying to the Production environment then the following is required

#### Azure Authentication

In a terminal run the following commands:

1. `az login`
2. `az account show`

If the name returned is not **CSL-Production** then run the following:

1. `az account set -s CSL-Production`
2. `az account show`

The environment will then be setup to deploy to **production**

For deployments to other environments, set the subscription to **CSL-Staging**

------------

### How to configure each environment for deployment

1. Clone this repository
2. Change into the `environments/<environmentName>` folder in a terminal
4. Run `terraform init`

------------

### Updating Terraform for Deployment

#### Unsecure variables

> **Warning**

> **Deprecated**: Variables are no longer stored in Terraform. To store variables in your App Services, please use the [Vault CLI](https://github.com/Civil-Service-Human-Resources/csl-vault) instead.

Unsecure variables can be updated in the `00-vars.tf` file. This file contains items such as docker tags, SKUs and various other settings

#### Secure variables

> **Warning**

> **Deprecated**: Variables are no longer stored in Terraform. Secure (secret) variables are now stored in a Key Vault. To store variables in your App Services, please use the [Vault CLI](https://github.com/Civil-Service-Human-Resources/csl-vault) instead.

Secure variables can be updated in the `${env}-vars.tf` file. This file contains items such as passwords and tokens

------------

### Terraform Deployment

Once the environment has been configured and updated as required for the deployment, run the appropriate set of commands

#### Full deployment

To deploy the entire suite of modules:

1. `terraform plan`
2. `terraform apply`

#### Targeted Deployment

Module names can be found in the `modules` directory.

To do a targeted deployment of a single module:

1. `terraform plan -target=module.lpg-ui`
2. `terraform apply -target=module.lpg-ui`

To do a targeted deployment of multiple modules:

1. `terraform plan -target=module.lpg-ui -target=module.lpg-learner-record`
2. `terraform apply -target=module.lpg-ui -target=module.lpg-learner-record`

Note the section in the cosmos module that needs to be un-commented for **stage** only deploys.

------------

### FAQs / Troubleshooting

#### How to turn on debug mode

Terraform has detailed logs which can be enabled by setting the `TF_LOG` environment variable to any value. This will cause detailed logs to appear on stderr.
e.g.
`TF_LOG=DEBUG terraform plan`

#### Terraform fails due to out-of-date version of terraform

If terraform fails with the following message:

e.g.
`The current version of Terraform to use is 0.12.24 and above. Attempting to use a lower version can throw errors.`

or

`Error: Error loading state: state snapshot was created by Terraform v0.13.0, which is newer than current v0.12.29; upgrade to Terraform v0.13.0 or greater to work with this state`

Run the following command to update terraform version:

`brew upgrade terraform`

Verify new version is correct:

`terraform -v`

If necessary update this README.md to reflect current version of terraform.

#### Terraform appears to hang while doing plan / apply

Terraform takes some time to process the entire graph of resources to be deployed. Wait for it to complete.
Alternatively, use the `-target` param to target any specific modules, thus reducing wait time.

#### Terraform destroy doesn't remove Web Apps / App Services

This is a known limitation of using ARM templates embedded into a terraform ` "azurerm_template_deployment"`

To destroy the object created by terraform, do so either in Azure Portal or via the Azure CLI

Find more information on this limitation here:
https://www.terraform.io/docs/providers/azurerm/r/template_deployment.html

#### terraform plan fails with 401

If terraform plan fails with 401, it may indicate that the Azure Service Principal for that subscription has expired.
e.g.

``` bash
Error: Error building account: Error getting authenticated object ID: Error listing Service Principals:... Refresh request failed. Status Code = '401
```

To resolve this issue, generate new Service Principal credentials as per the readme in `scripts/service-principal/README.md`

#### terraform plan fails with " Error parsing json result from the Azure CLI: Error waiting for the Azure CLI: exit status 2"

If terraform plan fails with the following error, this can imply that there is an issue with credentials:

``` bash
Error: Error building account: Error getting authenticated object ID: Error parsing json result from the Azure CLI: Error waiting for the Azure CLI: exit status 2


  on state.tf line 10, in provider "azurerm":
  10: provider "azurerm" {
 
```

The easiest workaround is to uninstall, re-install and login to the Azure CLI tool:

``` bash
brew uninstall azure-cli
brew update && brew install azure-cli
az login
```
