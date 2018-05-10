#!/bin/bash -ev

# This script should get a list of all outbound ip's and add them to the postgres instance firewall rules
# It may take a while (few minutes) for the changes to actual take effect in Azure
# Assumes that you are logged in via Azure CLI and have it installed
#
# Inputs:
# Resource group
# Web App for Container name
#
# Example: ./add_ip.sh lpgtest lpg-lpgtest-wso2

IN=$(az webapp show -g $1 -n $2 --query possibleOutboundIpAddresses -o tsv)
existing=$(az mysql server firewall-rule list -g $1 -s lpg-$1-mysql | grep -i startipaddress)

ipList=$(echo ${IN} | tr "," "\n")
for i in ${ipList}
do
  # do something here
  if [[ ${existing} != *"${i}"* ]]; then
    echo "Adding rule for ${i}"
    addRule=$(az mysql server firewall-rule create -g $1 -s lpg-$1-mysql --name Rule_${1}_${i//./} --start-ip-address ${i} --end-ip-address ${i})
  fi
done