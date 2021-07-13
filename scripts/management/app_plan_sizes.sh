#!/bin/bash -e

# This script will list the Docker images for the Azure Webapp for Containers within the resource group provided
# Ensure that you've already logged in to Azure via the CLI
#
# Required arguments: resource group name
#
# Example: ./app_plan_sizes.sh lpgtest

echo "Note that it may run a little slow, due to the number of calls to query Azure"


#az appservice plan show -g lpgtest -n lpg-lpgtest-lpg-management-uiserviceplan --query sku.size

#az appservice plan list | grep -i \"name\"\: | awk  -F ':' '{gsub(/\"|\,/,"")}1 {print $2}


appservices=$(az appservice plan list | grep -i \"name\"\: | grep -i $1  | awk  -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')

read -a arr <<< $appservices
for i in "${arr[@]}"
do
    size=$(az appservice plan show -g $1 -n $i --query sku.size)
    echo $i : $size
done