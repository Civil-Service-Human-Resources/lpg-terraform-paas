#!/bin/bash -e
# Forces the default-identity parameter to be not-null in cosmos.
# This is required to fix the default_identity_type bug, wherein
# Terraform will repeatedly attempt to set  default_identity_type
# to FirstPartyIdentity, but the actual MS ARM API will override and
# set to null. Context: https://github.com/hashicorp/terraform-provider-azurerm/issues/14439

RESOURCE_GROUP=$1
COSMOS_DB_NAME=$2

echo creating SystemAssignedIdentity
az cosmosdb identity assign -g "${RESOURCE_GROUP}" -n "${COSMOS_DB_NAME}"
echo setting default identities
az cosmosdb update -g "${RESOURCE_GROUP}" -n "${COSMOS_DB_NAME}" --default-identity SystemAssignedIdentity
az cosmosdb update -g "${RESOURCE_GROUP}" -n "${COSMOS_DB_NAME}" --default-identity FirstPartyIdentity
echo removing SystemAssignedIdentity
az cosmosdb identity remove -g "${RESOURCE_GROUP}" -n "${COSMOS_DB_NAME}"
