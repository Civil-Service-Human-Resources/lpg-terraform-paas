#!/bin/bash

az login --service-principal --username "${AZURE_CLIENT_ID_S}" --password "${AZURE_CLIENT_SECRET_S}" --tenant "${AZURE_TENANT_ID_S}"

cd /home/

bash resetQueryBuilderCache.sh "${AZURE_SUBSCRIPTION_ID_S}" prod