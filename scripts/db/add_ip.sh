#!/bin/bash -e
#
# Script to update the firewalls on mysql and redis instances with
# the ip's of the webapps
#
# Note that you may need to add a firewall entry to an instance before using this script,
# otherwise the empty string can cause it to fail to add ip's
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
orgRedis="lpg-$1-redis-org"
cslServiceRedis="lpg-$1-redis-csl-service"

SERVICES_TO_UPDATE="${gpMysql} ${llMysql} ${sessionRedis} ${orgRedis} ${cslServiceRedis}"

identityOutboundIPs=$(az webapp show -g $1 -n ${identityApp} --query possibleOutboundIpAddresses -o tsv)
transchiverOutboundIPs=$(az webapp show -g $1 -n ${transchiverApp} --query possibleOutboundIpAddresses -o tsv)

identityIPList=$(echo ${identityOutboundIPs} | tr "," "\n")
transchiverIPList=$(echo ${transchiverOutboundIPs} | tr "," "\n")

for SERVICE in ${SERVICES_TO_UPDATE}
do
    case $SERVICE in
        ${gpMysql})
            echo "Firewall setting for ${gpMysql}"
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
            echo "Firewall setting for ${llMysql}"
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
            echo "Firewall setting for ${sessionRedis}"
            redisFirewallList=$(az redis firewall-rules list -g $1 -n ${sessionRedis} | grep -i startIp || true)
            for ip in ${identityIPList}
            do
                if [[ ${redisFirewallList} != *"${ip}"* ]]; then
                    echo "Adding rule to Redis for ${ip}"
                    addRedisRule=$(az redis firewall-rules create -g $1 -n ${sessionRedis} --rule-name Rule_${1}_${ip//./} --start-ip ${ip} --end-ip ${ip})
                fi
            done
            ;;
        ${orgRedis})
            echo "Firewall setting for ${orgRedis}"
            redisFirewallList=$(az redis firewall-rules list -g $1 -n ${orgRedis} | grep -i startIp || true)
            for ip in ${identityIPList}
            do
                if [[ ${redisFirewallList} != *"${ip}"* ]]; then
                    echo "Adding rule to Redis for ${ip}"
                    addRedisRule=$(az redis firewall-rules create -g $1 -n ${orgRedis} --rule-name Rule_${1}_${ip//./} --start-ip ${ip} --end-ip ${ip})
                fi
            done
            ;;
        ${cslServiceRedis})
            echo "Firewall setting for ${cslServiceRedis}"
            redisFirewallList=$(az redis firewall-rules list -g $1 -n ${cslServiceRedis} | grep -i startIp || true)
            for ip in ${identityIPList}
            do
                if [[ ${redisFirewallList} != *"${ip}"* ]]; then
                    echo "Adding rule to Redis for ${ip}"
                    addRedisRule=$(az redis firewall-rules create -g $1 -n ${cslServiceRedis} --rule-name Rule_${1}_${ip//./} --start-ip ${ip} --end-ip ${ip})
                fi
            done
            ;;
    esac
done
