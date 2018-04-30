#!/bin/bash -e

echo "This script will list the Docker images for the Azure Webapp for Containers within the resource group provided"
echo "Ensure that you've already logged in to Azure via the CLI"
echo "Note that it may run a little slow, due to the number of calls to query Azure"

if [[ $# -eq 0 ]]; then
  echo "Please pass the resource group name"
  exit 1
fi

# this command gets the list space delimited
#resourcelist=$(az resource list --resource-group $1 |grep -i \"id\"\: | grep -i sites| awk  -F ':' '{gsub(/\"|\,/,"")}1 {printf $2}')
resourcelist=$(az resource list --resource-group $1 |grep -i \"id\"\: | grep -i sites| awk  -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')

# This doesn't filter the results correctly, brings back a list of all env vars.
# The filter only works for a single resource not a list
#az webapp config appsettings list -g $1 --ids $resourcelist -o table --query "[?name=='DOCKER_CUSTOM_IMAGE_NAME']"

# convert the resource list into an array and itterate through
read -a arr <<< $resourcelist
echo $1
for i in "${arr[@]}"
do
  webapp=$(awk -F/ '{print $9}' <<<$i)
  echo $webapp : $(az webapp config container show -g $1 --ids $i -o table --query "[?name=='DOCKER_CUSTOM_IMAGE_NAME'].[value]" | grep -i cshr)
done
