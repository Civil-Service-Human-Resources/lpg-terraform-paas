#!/bin/bash -ex

echo "This script will check the redis password for non URL safe characters and regenerate if any are found."
echo "You need to have logged in via Azure CommandLine (az-cli)"
echo "Parameters needed are: ResourceGroup, name of Redis cache"

key=$(az redis list-keys -g $1 -n $2 -o tsv| awk -F ' ' '{print $1}')

if [[ "$key" =~ [^0-9A-Za-z\=]+ ]] ; then
  echo "We need a new password, regenerating now"
  while [[ "$key" =~ [^0-9A-Za-z\=]+ ]]
  do
    key=$(az redis regenerate-keys --key-type Primary -g $1 -n $2 -o tsv| awk -F ' ' '{print $1}')
  done
else
  echo "Password is ok"
fi
