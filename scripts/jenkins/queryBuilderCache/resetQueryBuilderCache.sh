#!/bin/bash

# Delete the queryBuilderCaches and queryBuilderCacheValues collections from Cosmos

Subscription=$1
Env=$2 #This is the switch to apply to appropriate environment e.g. prod

#This section ensure connection to the appropriate subscription  (CSL-Staging | CSL-Production)
{
	echo "Connecting to Subscription "$Subscription
	az account set --subscription $Subscription
	echo "Successfully connected."
}||{
	echo "Unable to connect to Subscription: "$Subscription
}

#This section deletes the first of two collections: queryBuilderCacheValues
{
	echo "Deleting queryBuilderCacheValues... from lpg"$Env
	az cosmosdb collection delete  --resource-group lpg$Env --db-name admin --collection-name queryBuilderCacheValues --name lpg-lpg$Env-cosmos
	echo "queryBuilderCacheValues has been successfully deleted."
}||{
	echo "Unable to delete queryBuilderCacheValues."
}

#This section deletes the first of two collections: queryBuilderCaches
{
        echo "Deleting queryBuilderCaches... from lpg"$Env
        az cosmosdb collection delete  --resource-group lpg$Env --db-name admin --collection-name queryBuilderCaches --name lpg-lpg$Env-cosmos
        echo "queryBuilderCaches has been successfully deleted."
}||{
        echo "Unable to delete queryBuilderCaches."
}

echo "Script has successfully completed."
