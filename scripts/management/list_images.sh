#!/bin/bash -evx

echo "Get a list of the resource id's"
resourcelist=$(az resource list --resource-group $1 |grep -i \"id\"\: | grep -i sites| awk  -F ':' '{gsub(/\"|\,/,"")}1 {printf $2}')

echo "Use this in the command below"
az webapp config appsettings list -g $1 --ids $resourcelist -o table --query "[?name=='DOCKER_CUSTOM_IMAGE_NAME']"

# az webapp config appsettings list -g lpgdev --ids /subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/lpgdev/providers/Microsoft.Web/sites/lpg-lpgdev-learning-locker-api-worker /subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/lpgdev/providers/Microsoft.Web/sites/lpg-lpgdev-learning-locker-ui /subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/lpgdev/providers/Microsoft.Web/sites/lpg-lpgdev-learning-locker-xapi /subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/lpgdev/providers/Microsoft.Web/sites/lpg-lpgdev-lpg-learner-record /subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/lpgdev/providers/Microsoft.Web/sites/lpg-lpgdev-lpg-learning-catalogue /subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/lpgdev/providers/Microsoft.Web/sites/lpg-lpgdev-lpg-management-ui /subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/lpgdev/providers/Microsoft.Web/sites/lpg-lpgdev-lpg-ui /subscriptions/3d841a15-ecbe-4132-8fa9-9cde2de0c52e/resourceGroups/lpgdev/providers/Microsoft.Web/sites/lpg-lpgdev-wso2 -o table --query '[?name=='\''DOCKER_CUSTOM_IMAGE_NAME'\'']'