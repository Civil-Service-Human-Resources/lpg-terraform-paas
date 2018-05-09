#!/bin/bash -e

# This script will check the redis password for non URL safe characters and regenerate if any are found.
# You need to have logged in via Azure CommandLine (az-cli)
#
# Required parameters: resource group name, name of Redis cache
#
# Example: ./redis_password.sh lpgtest lpg-lpgtest-redis

key=$(az redis list-keys -g $1 -n $2 -o tsv| awk -F ' ' '{print $1}')

if [[ "$key" =~ [^0-9A-Za-z\=]+ ]] ; then
  echo "We need a new password, regenerating now"
  while [[ "$key" =~ [^0-9A-Za-z\=]+ ]]
  do
    key=$(az redis regenerate-keys --key-type Primary -g $1 -n $2 -o tsv| awk -F ' ' '{print $1}')
  done
  apiworker=$(az webapp config appsettings set -g $1 -n lpg-$1-learning-locker-api-worker --settings REDIS_PASSWORD=$key)
  xapi=$(az webapp config appsettings set -g $1 -n lpg-$1-learning-locker-xapi --settings REDIS_URL=redis://$2.redis.cache.windows.net:6380/0?password=$key)
  echo "Primary Redis key is now: $key"
  echo "This password is used in the following places, please check they have been updated:"
  echo " * learning-locker-api-worker - REDIS_PASSWORD"
  echo " * learning-locker-xapi - REDIS_URL"
else
  echo "Password is ok, nothing done"
fi

