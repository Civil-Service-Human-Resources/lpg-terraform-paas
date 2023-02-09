#!/bin/bash -e

ENV=$1
KEYVAULT_USERS_GROUP_OBJECTID=$(az ad group list --display-name "CSL KeyVault Users" --query "[0].id" | tr -d '"')

if [[ -z "$access_key" && "$ENV" != "unlink" ]]; then 
	echo "This script requires an \"access_key\" environment variable to be set. This must be the access key for the blob storage account that holds the state files."
	exit
fi

if [[ "$PWD" == */environments/master ]]; then
    echo "Environment setup initialising"
else
    echo "Environment setup failed"
    echo "Please run from environments/master directory"
    exit
fi

if [[ "$ENV" =~ ^(production|staging|integration|perf)$ ]]; then
    echo "Setting symlink: $1"
elif [[ "$ENV" == "unlink" ]]; then
    echo "Removing .terraform state directory"
    rm -rf .terraform

    echo "Un-linking any symlink files"
    rm state.tf
    rm vars.tf
    rm docker-tags-vars.tf
    
    echo "Environment unlinked - exiting"
    exit 1
else
    echo "$ENV is not a valid environment"
    exit
fi

cp -r ../$ENV/docker-tags-vars.tf .
cp -r ../$ENV/state.tf .
cp -r ../$ENV/vars.tf vars.tf

if [[ $ENV =~ ^(integration|staging|perf)$ ]]; then
    SUBSCRIPTION_NAME="CSL-Staging"
else
    SUBSCRIPTION_NAME="CSL-Production"
fi

az account set --subscription $SUBSCRIPTION_NAME

echo """access_key=\"$access_key\"""" > backend.conf

terraform init -backend-config=backend.conf

terraform plan -out tfplan-$ENV -var keyvault_users_group_object_id=$KEYVAULT_USERS_GROUP_OBJECTID
