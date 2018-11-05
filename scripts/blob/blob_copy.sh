#!/bin/bash -e

#######################################
##
## Script to snapshot all blobs in a container when run
##
## Usage:
## ./blob_copy.sh
##
## Created by:       Robert Marks
## Creation Date:    05/11/2018
##
## soft delete is enabled on the azure storage account with 14 days recovery available
##
########################################

# todays date
date=`date +%Y-%m-%d`
# todays date -7 days
oldDate=$(date -v-7d +'%Y-%m-%d')

# required vars
sourceContainer=
destinationContainer=
account=
key=

# get a list of source blob names only & read it to blobarr
sourceBlobs=$(az storage blob list --container-name $sourceContainer --account-name $account --account-key $key | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
read -a blobarr <<< $sourceBlobs

# for each blob in blobarr copy it to the destination container with date-blobname format
for blob in "${blobarr[@]}"; do
    az storage blob copy start --account-name $account --destination-blob $date-$blob --destination-container $destinationContainer --source-blob $blob --source-container $sourceContainer
done


# get a list of copied blob names only & read it to copyarr
copyBlob=$(az storage blob list --container-name $destinationContainer --account-name $account --account-key $key | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
read -a copyarr <<< $copyBlob

# for each blob in copyarr if the name format matches oldDate* format then delete
for copy in "${copyarr[@]}"; do
    if [[ $copy == $oldDate* ]] ; then
        az storage blob delete --container-name $destinationContainer --name $copy --account-key $key --account-name $account
    fi
done