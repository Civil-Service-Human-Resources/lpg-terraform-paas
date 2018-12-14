#!/bin/bash -e

# This script will deploy elasticsearch to azure based on the configuration stored in the .json file selected
#
# You need to set subID / rgName / env vars
# For the env var that is the name of the json file you want to use (integration.json / staging.json / production.json)
# The json files are stored securely in keybase
#
# Example: ./lpg-elastic.sh

# Fill out relevant details
subID=""
rgName=""
env=""
rgLocation=""
deployName=""

# Set the subscription
az account set --subscription $subID

# Check if RG exists
exists=$(az group exists -n $rgName)

# Deploy
if [[ $exists != true ]] ; then
    echo "Creating RG"
    az group create --location $rgLocation --name $rgName
    echo "Deploying elastic from $env"
    az group deployment create -g $rgName -n $deployName --template-uri "https://raw.githubusercontent.com/elastic/azure-marketplace/master/src/mainTemplate.json" --parameters @$env
else
    echo "Deploying elastic from $env"
    az group deployment create -g $rgName -n $deployName --template-uri "https://raw.githubusercontent.com/elastic/azure-marketplace/master/src/mainTemplate.json" --parameters @$env
fi

# Set SSH to DENY to start
nsgName=$(az network nsg list -g $rgName | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}' | awk 'NR==7')
az network nsg rule update -g $rgName --nsg-name $nsgName -n SSH --access DENY
