#!/bin/bash -e

echo "This script will update the Docker image for a Azure Webapp for Container"
echo "Ensure that you've already logged in to Azure via the CLI"
echo "Please pass the webapp container name, resource group and docker tag (in order)"

if [[ $# -eq 0 ]]; then
  echo "You've forgotten the arguments, or supplied too few, please try again"
  exit 1
fi

if [[ $# -gt 3 ]]; then
  echo "Too many arguments, please try again"
  exit 1
fi

#az webapp config container set -n lpg-lpgdev-learning-locker-api-worker -g lpgdev -c cshr/lpg-learning-locker:213ad45eb11f7924fcec151e852bb729476279338f30ffb040daa3f2df896f5c-v2
az webapp config container set -n $1 -g $2 -c $3
