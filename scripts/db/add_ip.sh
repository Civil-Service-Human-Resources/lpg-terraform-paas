#!/bin/bash -ev
#
# Script to update the firewalls 
# on mysql and redis instances 
#
# Inputs:
# Resource group
#
# Example: ./add_ip.sh lpgtest

identityApp="lpg-$1-identity"
transchiverApp="lpg-$1-lpg-data-transchriver"

gpMysql="lpg-$1-gp"
llMysql="lpg-$1-ll"
sessionRedis="lpg-$1-redis-session"

SERVICES_TO_UPDATE="${gpMysql} ${llMysql} ${sessionRedis}"

identityOutboundIPs=$(az webapp show -g $1 -n ${identityApp} --query possibleOutboundIpAddresses -o tsv)
transchiverOutboundIPs=$(az webapp show -g $1 -n ${transchiverApp} --query possibleOutboundIpAddresses -o tsv)

identityIPList=$(echo ${identityOutboundIPs} | tr "," "\n")
transchiverIPList=$(echo ${transchiverOutboundIPs} | tr "," "\n")

for SERVICE in ${SERVICES_TO_UPDATE}
do
    case $SERVICE in
        ${gpMysql})
            gpFirewallList=$(az mysql server firewall-rule list -g $1 -s ${gpMysql} | grep -i startipaddress)
            for ip in ${identityIPList}
            do
                if [[ ${gpFirewallList} != *"${ip}"* ]]; then
                    echo "Adding rule for ${ip}"
                    addRule=$(az mysql server firewall-rule create -g $1 -s ${gpMysql} --name Rule_${1}_${ip//./} --start-ip-address ${ip} --end-ip-address ${ip})
                fi
            done
            ;;
        ${llMysql})
            llFirewallList=$(az mysql server firewall-rule list -g $1 -s ${llMysql} | grep -i startipaddress)
            for ip in ${transchiverIPList}
            do
                if [[ ${llFirewallList} != *"${ip}"* ]]; then
                    echo "Adding rule for ${ip}"
                    addRule=$(az mysql server firewall-rule create -g $1 -s ${llMysql} --name Rule_${1}_${ip//./} --start-ip-address ${ip} --end-ip-address ${ip})
                fi
            done
            ;;
        ${sessionRedis})
            sessionFirewallList=$(az redis firewall-rules list -g $1 -n ${sessionRedis} | grep -i startIp)
            for ip in ${identityIPList}
            do
                if [[ ${sessionFirewallList} != *"${ip}"* ]]; then
                    echo "Adding rule to Redis for ${ip}"
                    addRedisRule=$(az redis firewall-rules create -g $1 -n ${sessionRedis} --rule-name Rule_${1}_${ip//./} --start-ip ${ip} --end-ip ${ip})
                fi
            done
            ;;
    esac
done
