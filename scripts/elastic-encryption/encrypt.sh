#!/bin/bash

# Fix for Vault Issue
# https://github.com/Azure/azure-cli/issues/4318

# Provide your own unique Key Vault name
keyvault_name=robenv-kvault

# Key Vault resource group
keyvault_resource_group=robenv-kvault

# Provide your rbac app name
app_name=robenv_encrypt

# VM Resource group
resource_group=robenv

# Register the Key Vault provider and create a resource group.
#az provider register -n Microsoft.KeyVault
#az group create --name $keyvault_name --location uksouth

# Create a Key Vault for storing keys and enabled for disk encryption.
#az keyvault create --name $keyvault_name --resource-group $keyvault_name --location uksouth \
#    --enabled-for-disk-encryption True

# Create a key within the Key Vault.
az keyvault key create --vault-name $keyvault_name --name ${resource_group}-key --protection software

# Create an Azure Active Directory service principal for authenticating requests to Key Vault.
# Read in the service principal ID and password for use in later commands.
read sp_id sp_password <<< $(az ad sp create-for-rbac -n "$app_name" --query [appId,password] -o tsv)

# Grant permissions on the Key Vault to the AAD service principal.
az keyvault set-policy --resource-group $keyvault_resource_group --name $keyvault_name --spn $sp_id \
    --key-permissions wrapKey \
    --secret-permissions set

# Get all VM names to be encrypted
vmarr=($(az vm list -g $resource_group --show-details --query "[].{ name: name }" -o tsv))

# Encrypt the VM disks.
for vm in "${vmarr[@]}"; do
    az vm encryption enable --resource-group $resource_group --name $vm \
    --aad-client-id $sp_id \
    --aad-client-secret $sp_password \
    --disk-encryption-keyvault $keyvault_name \
    --key-encryption-key ${resource_group}-key \
    --volume-type all
done

# Output how to monitor the encryption status and next steps.
echo "The encryption process can take some time. View status with:

    az vm encryption show --resource-group myResourceGroup --name myVM --query [osDisk] -o tsv

When encryption status shows \`VMRestartPending\`, restart the VM with:

    az vm restart --resource-group myResourceGroup --name myVM"