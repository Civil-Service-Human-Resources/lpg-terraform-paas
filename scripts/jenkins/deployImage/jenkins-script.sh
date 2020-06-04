az login --service-principal --username "${AZURE_CLIENT_ID_S}" --password "${AZURE_CLIENT_SECRET_S}" --tenant "${AZURE_TENANT_ID_S}"

cd /home/

echo ${resourceGroup}
echo ${webappName}
echo ${label}

# our inconsistent naming makes this harder than it should be

# name of the service in Azure
name="lpg-${resourceGroup}-${webappName}"

# do a pattern match with the whole of the string to change the webapp name to
# match the repo name (which doesn't always match the name)
if [[ ${webappName} =~ ^(civil-servant-registry|identity|lpg-management|lpg-ui|lpg-data-transchriver)$ ]]; then
  if [[ ${webappName} = "identity" ]]; then
    webappName="identity-service"
  elif [[ ${webappName} = "lpg-ui" ]]; then
    webappName="lpg-services"
  elif [[ ${webappName} = "lpg-management" ]]; then
    webappName="lpg-management-ui"
  elif [[ ${webappName} = "lpg-data-transchriver" ]]; then
    webappName="data-transchriver"
  else
    webappName="${webappName}-service"
  fi
fi

# location of the artefacts in the repo
repo="lpgregistry.azurecr.io/${webappName}:${label}"

echo ${name}
echo ${repoName}

az webapp config container set -g ${resourceGroup} -n ${name} -c ${repo}