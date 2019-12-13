#!/usr/bin/env bash
ENV=$1

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
    unlink state.tf
    unlink 00-vars.tf
    unlink *-vars.tf
    
    echo "Environment unlinked - exiting"
    exit 1
else
    echo "$ENV is not a valid environment"
    exit
fi

echo "Removing .terraform state directory"
rm -rf .terraform

echo "Un-linking any symlink files"
unlink state.tf
unlink 00-vars.tf
unlink *-vars.tf

echo "Creating symlink for $ENV files"
ln -s ../00-$ENV/00-vars.tf
ln -s /keybase/team/lpg/ops/azure/cabinet-azure/00-$ENV/state.tf
ln -s /keybase/team/lpg/ops/azure/cabinet-azure/00-$ENV/$ENV-vars.tf

echo "Initialising Terraform"
terraform init

echo "Complete"
