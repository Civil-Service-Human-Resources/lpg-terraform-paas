#!/bin/bash -e

#######################################
##
## Script to snapshot all blobs in a container when run
##
## Usage:
## ./blob_snapshot.sh
##
## Created by:       Robert Marks
## Creation Date:    31/10/2018
##
## Waiting on Azure support for an issue around listing blob snapshots (currently null returned)
##
########################################

container=
account=
key=

blobs=$(az storage blob list --container-name $container --account-name $account --account-key $key | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
read -a blobarr <<< $blobs

for blob in "${blobarr[@]}"; do
    az storage blob snapshot --container-name $container --name $blob --account-name $account --account-key $key
done