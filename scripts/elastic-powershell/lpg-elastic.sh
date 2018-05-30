#!/bin/bash -e

subID=""
rgName="lpg-prod-elastic"
rgLocation="UKSouth"
deployName="prod-elastic-thurs10"

az account set --subscription $subID

az group create --location $rgLocation --name $rgName

az group deployment create -g $rgName -n $deployName --template-uri "https://raw.githubusercontent.com/elastic/azure-marketplace/master/src/mainTemplate.json" --parameters @lpg-prod-elastic-parameters.json

#az network nsg rule update -g $rgName --nsg-name