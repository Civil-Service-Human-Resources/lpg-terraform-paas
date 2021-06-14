az login --service-principal --username "${AZURE_CLIENT_ID_S}" --password "${AZURE_CLIENT_SECRET_S}" --tenant "${AZURE_TENANT_ID_S}"

az webapp stop --name lpg-lpgprod-lpg-data-transchriver --resource-group lpgprod

az webapp start --name lpg-lpgprod-lpg-data-transchriver --resource-group lpgprod

