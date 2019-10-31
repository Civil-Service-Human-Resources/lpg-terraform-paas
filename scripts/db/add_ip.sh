#!/bin/bash -ev
##### BROKEN AT THE MOMENT ######
## If the Redis firewall list is empty the script breaks
## FIX ME


# This script should get a list of all outbound ip's and add them to the mysql instance firewall rules
# It may take a while (few minutes) for the changes to actually take effect in Azure
# Assumes that you are logged in via Azure CLI and have it installed
#
# Inputs:
# Resource group
# Web App for Container name
#
# Example: ./add_ip.sh lpgtest lpg-lpgtest-wso2

IN=$(az webapp show -g $1 -n $2 --query possibleOutboundIpAddresses -o tsv)
existingMySQL=$(az mysql server firewall-rule list -g $1 -s lpg-$1-mysql | grep -i startipaddress)
# existingRedis=$(az redis firewall-rules list -g $1 -n lpg-$1-redis-session | grep -i startIp)

ipList=$(echo ${IN} | tr "," "\n")
az webapp show -g $1 -n $2 --query possibleOutboundIpAddresses -o tsv
echo ${IN}

for i in ${ipList}
do
  # do something here
  if [[ ${existingMySQL} != *"${i}"* ]]; then
    echo "Adding rule for ${i}"
    addMySQLRule=$(az mysql server firewall-rule create -g $1 -s lpg-$1-gp --name Rule_${1}_${i//./} --start-ip-address ${i} --end-ip-address ${i})
  fi
  # if [[ ${existingRedis} != *"${i}"* ]]; then
    echo "Adding rule to Redis for ${i}"
    addRedisRule=$(az redis firewall-rules create -g $1 -n lpg-$1-redis-session --rule-name Rule_${1}_${i//./} --start-ip ${i} --end-ip ${i})
  # fi
done