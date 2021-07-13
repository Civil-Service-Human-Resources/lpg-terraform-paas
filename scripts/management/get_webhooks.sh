#!/bin/bash -e

# Get the webhooks for a resource group
# As always, need to have logged in via Azure CLI and for the CLI to be installed
#
# Parameters: resource group name
#
# Example: ./get_webhooks.sh lpgtest

resourcelist=$(az resource list --resource-group $1 |grep -i \"id\"\: | grep -i sites| awk  -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')

read -a arr <<< $resourcelist
echo $1
for i in "${arr[@]}"
do
  webapp=$(awk -F/ '{print $9}' <<<$i)
  echo ${webapp} : $(az webapp deployment container show-cd-url -g $1 -n ${webapp} --query CI_CD_URL -o tsv)
done