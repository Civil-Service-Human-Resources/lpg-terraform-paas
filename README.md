# LPG Terraform

### Dependencies
In order to run the code in this repository, the following should be installed on the environment that is being used

#### Core binaries

- Terraform v0.12.20(as of writing)
- Azure CLI
- Keybase

#### Access / Permissions

- Azure Account for LPG
- Keybase Account linked to team

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

For deployments to environments set the subscription to **CSL-Staging**

------------

### Keybase Setup

Ensure that keybase is enabled for local file browsing

------------

### How to configure the environment for deployment

1. Clone this repository
2. Change into the `environments/master` folder in a terminal
3. Run the symlink script
    1. Script can be found here: `scripts/management/symlink.sh`
    2. The script is run as: `./../../scripts/management/symlink.sh ${env}`
        1. Replace `${env}` with the environment name you wish to configure for
    3. This will symlink the following required files:
        1. `state.tf`
        2. `00-vars.tf` (unsecure vars)
        3. `${env}-vars.tf` (secure vars)
4. Run `terraform init`

------------

### Updating Terraform for Deployment

#### Unsecure variables

Unsecure variables can be updated in the `00-vars.tf` file. This file contains items such as docker tags, SKUs and various other settings

#### Secure variables

Secure variables can be updated in the `${env}-vars.tf` file. This file contains items such as passwords and tokens

------------

### Terraform Deployment

Once the environment has been configured and updated as required for the deployment, run the appropriate set of commands

#### Full deployment

To deploy the entire suite of modules:
1. `terraform plan`
2. `terraform apply`

#### Targeted Deployment

Module names can be found in the `environments/main.tf` file

To do a targeted deployment of a single module:
1. `terraform plan -target=module.lpg-ui`
2. `terraform apply -target=module.lpg-ui`

To do a targeted deployment of multiple modules:
1. `terraform plan -target=module.lpg-ui -target=module.lpg-learner-record`
2. `terraform apply -target=module.lpg-ui -target=module.lpg-learner-record`

Note the section in the cosmos module that needs to be un-commented for **stage** only deploys.

------------

### FAQs / Troubleshooting

#### Terraform appears to hang while doing plan / apply

Terraform takes some time to process the entire graph of resources to be deployed. Wait for it to complete

#### Terraform destroy doesn't remove Web Apps / App Services

This is a known limitation of usign ARM templates embedded into a terraform ` "azurerm_template_deployment"`

To destroy the object created by terraform, do so either in Azure Portal or via the Azure CLI

Find more information on this limitation here:
https://www.terraform.io/docs/providers/azurerm/r/template_deployment.html