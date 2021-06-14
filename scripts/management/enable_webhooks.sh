#!/bin/bash -e

# Enable the webhooks for a resource group
# As always, need to have logged in via Azure CLI and for the CLI to be installed
#
# Parameters: resource group name
#
# Example: ./enable_webhooks.sh lpgtest

resourcelist=$(az resource list --resource-group $1 |grep -i \"id\"\: | grep -i sites| awk  -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')

read -a arr <<< $resourcelist
echo $1
for i in "${arr[@]}"
do
  webapp=$(awk -F/ '{print $9}' <<<$i)
  something=$(az webapp deployment container config -g $1 -n ${webapp} --enable-cd true)
done