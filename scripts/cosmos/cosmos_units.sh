#!/bin/bash -e

# This script will set the RUs for the specified CosmosDB
# You need to have logged in via Azure CommandLine (az-cli)
#
# Required parameters: resource group name, name of Redis cache, new throughput value
#
# Example: ./cosmos_units.sh lpgtest lpg-lpgtest-cosmos 400

key=$(az cosmosdb list-keys -g $1 -n $2 -o tsv | awk -F ' ' '{print $1}')
exists=$(az cosmosdb database exists --db-name admin -n $2 --key "$key")

if [[ "$exists" == true ]] ; then
    echo "admin database exists - changing RUs per collection"
    db=$(az cosmosdb collection list --db-name admin -n $2 --key "$key" | grep -i \"id\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
    read -a arr <<< $db

    for i in "${arr[@]}"; do
        echo "Updating $i RU"
        az cosmosdb collection update --c "$i" -d admin --throughput "$3" --key "$key" -n $2
    done
else
    echo "admin database does not exist - exiting"
fi