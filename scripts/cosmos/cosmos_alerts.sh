#!/bin/bash -e

#######################################
##
## This script will update the cosmos units for all cosmos DBs based on time frame
##
##
## Usage:
## ./cosmos_alerts.sh
##
## Created by:       Robert Marks
## Creation Date:    03/08/2018
##
########################################

#az monitor alert create -n rule1 -g {ResourceGroup} --target {VirtualMachineID} \
#                            --condition "Percentage CPU > 90 avg 5m" \
#                            --action email bob@contoso.comann@contoso.com --email-service-owners \
#                            --action webhook https://www.contoso.com/alerts?type=HighCPU \
#                            --action webhook https://alerts.contoso.com apiKey={APIKey} type=HighCPU

subs=$(az account list | grep -i \"id\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
read -a subsarr <<< $subs

for s in "${subsarr[@]}"; do

    az account set --subscription "${s}"
    collection=$(az cosmosdb list | grep -i \"name\"\: | awk -F ':' '{gsub(/\"|\,/,"")}1 {print $2}')
    read -a col <<< $collection

    for c in "${col[@]}"; do
        g=$(echo $c | cut -d'-' -f 2)
        az monitor alert create -n "$g-test" -g "$g" --target $c --condition "Average Requests per Second > 600 CountPerSecond" --action email robertm@kainos.com
        az monitor alert create -n "$g-test" -g "$g" --target $c --condition "Throttled Requests > 10 count" --action email robertm@kainos.com
    done

done
