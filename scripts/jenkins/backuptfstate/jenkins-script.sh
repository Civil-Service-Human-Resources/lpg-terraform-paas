#!/bin/bash -xe

az login --service-principal --username "${AZURE_CLIENT_ID_S}" --password "${AZURE_CLIENT_SECRET_S}" --tenant "${AZURE_TENANT_ID_S}"

# Jenkins server uses GNU date

# todays date
date=`date +%Y-%m-%d-%H%M%S`
# todays date -7 days
#oldDate=$(date --date='7 days ago' +'%Y-%m-%d')

# required vars
sourceContainer=tfstatesecure
destinationContainer=tfstatecopy
account=$AZURE_STORAGE_ACCOUNT_NAME
key=$AZURE_STORAGE_ACCOUNT_KEY

# get a list of source blob names only & read it to blobarr
sourceBlobs=$(az storage blob list --container-name $sourceContainer --account-name $account --account-key $key | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
read -a blobarr <<< $sourceBlobs

# for each blob in blobarr copy it to the destination container with date-blobname format
for blob in "${blobarr[@]}"; do
    az storage blob copy start --account-name $account --account-key $key --destination-blob $date-$blob --destination-container $destinationContainer --source-blob $blob --source-container $sourceContainer
done


# get a list of copied blob names only & read it to copyarr
copyBlob=$(az storage blob list --container-name $destinationContainer --account-name $account --account-key $key | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
read -a copyarr <<< $copyBlob