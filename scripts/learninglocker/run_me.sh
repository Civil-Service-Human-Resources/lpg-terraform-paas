#!/bin/bash 

# This script wraps the add-admin-user.sh and provides it with all variables it needs from the environment
# As always, assumption that you've logged in via Azure CLI - and that its installed
# Also docker is required to be running
#
# Required variables: resource group
# Example: ./run_me.sh lpgtest

# apikey=$(az webapp config appsettings set -g $1 -n lpg-$1-lpg-learer-record --settings REDIS_PASSWORD=$key)

# xapikey=$(az webapp config appsettings list -g $1 -n lpg-$1-lpg-learner-record --query "[?name=='XAPI_USERNAME'].[value]" -o table | sed -n '3p')
# xapivalue=$(az webapp config appsettings list -g $1 -n lpg-$1-lpg-learner-record --query "[?name=='XAPI_PASSWORD'].[value]" -o table | sed -n '3p')
# lockeruser=$(az webapp config appsettings list -g $1 -n lpg-$1-lpg-learner-record --query "[?name=='AUTH_USER'].[value]" -o table | sed -n '3p')
# lockerpass=$(az webapp config appsettings list -g $1 -n lpg-$1-lpg-learner-record --query "[?name=='AUTH_PASSWORD'].[value]" -o table | sed -n '3p')
# mongopath=$(az webapp config appsettings list -g $1 -n lpg-$1-learning-locker-ui --query "[?name=='MONGODB_PATH'].[value]" -o table | sed -n '3p')
# dockertag=$(az webapp config container show -g $1 -n lpg-$1-learning-locker-ui -o table --query "[?name=='DOCKER_CUSTOM_IMAGE_NAME'].[value]" | sed -n '3p' | sed 's/\DOCKER\|cshr\/lpg-learning-locker\://g')
# path=$(pwd)

# echo lockeruser $lockeruser 
# echo lockerpass $lockerpass 
# echo xapikey $xapikey 
# echo xapivalue $xapivalue 
# echo mongopath $mongopath
# echo $dockertag

# (exec $path/add-admin-user.sh $lockeruser $lockerpass $xapikey $xapivalue \"$mongopath\" $dockertag)

echo Please read the readme.md file. This script no longer works, so the steps in the readme need to be followed instead.