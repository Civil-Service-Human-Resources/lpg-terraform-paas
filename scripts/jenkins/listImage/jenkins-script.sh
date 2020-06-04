#!/bin/bash

az login --service-principal --username "${AZURE_CLIENT_ID_S}" --password "${AZURE_CLIENT_SECRET_S}" --tenant "${AZURE_TENANT_ID_S}"

cd /home/

echo ${resourceGroup}
echo ${webappName}

name="lpg-${resourceGroup}-${webappName}"

echo ${name}

az webapp config container show -g ${resourceGroup} -n ${name}