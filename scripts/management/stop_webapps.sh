#!/bin/bash -e

# This script will stop or start all webapps in a given resource group providing you're on the right subscription
# Ensure that you've already logged in to Azure via the CLI
#
# Required parameters: resource group name, stop or start
#
# Example: ./webapps_power.sh lpgdev stop
# Example: ./webapps_power.sh lpgdev start

echo "Note that it may run a little slow, due to the number of calls to query Azure"

# this command gets the list space delimited
resourcelist=$(az resource list --resource-group $1 |grep -i \"id\"\: | grep -i sites| awk  -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')

# convert the resource list into an array and iterate through
read -a arr <<< $resourcelist
echo "Working on this env:" $1
for i in "${arr[@]}"
do
  webapp=$(awk -F/ '{print $9}' <<<$i)
  echo "Stopping" $webapp
  az webapp $2 -n $9 -g $1
done
