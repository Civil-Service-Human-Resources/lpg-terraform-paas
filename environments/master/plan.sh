#!/bin/bash -e

ENV=$1
export TF_VAR_keyvault_users_group_object_id=$(az ad group list --display-name "CSL KeyVault Users" --query "[0].id" | tr -d '"')

if [[ -z "$ACCOUNT_KEY" && "$ENV" != "unlink" ]]; then 
	az account set --subscription CSL-Production
	ACCOUNT_KEY=$(az storage account keys list --resource-group lpgterraform --account-name lpgterraformsecure --query '[0].value' -o tsv)
	export ARM_ACCESS_KEY=$ACCOUNT_KEY
fi

if [[ "$PWD" == */environments/master ]]; then
    echo "Environment setup initialising"
else
    echo "Environment setup failed"
    echo "Please run from environments/master directory"
    exit
fi

if [[ "$ENV" =~ ^(production|staging|integration|perf|unlink)$ ]]; then
    echo "Removing .terraform state directory"
    rm -rf .terraform

    echo "Un-linking any symlink files"
    rm state.tf
    rm vars.tf
else
    echo "$ENV is not a valid environment"
    exit
fi

if [[ "$ENV" == "unlink" ]]; then
    echo "Environment unlinked - exiting"
    exit 1
fi

echo "Setting symlink: $1"
cp -r ../$ENV/state.tf .
cp -r ../$ENV/vars.tf vars.tf

if [[ $ENV =~ ^(integration|staging|perf)$ ]]; then
    SUBSCRIPTION_NAME="CSL-Staging"
else
    SUBSCRIPTION_NAME="CSL-Production"
fi

az account set --subscription $SUBSCRIPTION_NAME

terraform init

terraform plan -out tfplan-$ENV
