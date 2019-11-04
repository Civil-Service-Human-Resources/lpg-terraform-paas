#!/bin/bash -e

# This script will cleanup all unused containers from the ACR.
#
# Required arguments: azure container registry name
#
# Example: ./acr_cleanup.sh registryname

registry=${1}

# Function to set to correct subscription per env
setSub() {
    if [[ ${1} == "integration" ]] || [[ ${1} == "staging" ]]; then
        az account set -s CSL-Staging
    else
        az account set -s CSL-Production
    fi
}

# Function to get the container from webapp config
getContainer() {
    container=`az webapp config container show -g lpg${1} --name ${2} -o table --query "[?name=='DOCKER_CUSTOM_IMAGE_NAME'].[value]" | grep -i \: | awk  -F ':' '{gsub(/\"|\,/,"")}1 {print $2}'`
}

# Function to cleanup ACR
cleanup() {
    IMAGES_FULL=`az acr repository show-tags --repository ${1} --name ${registry} -o tsv | sort`
    
    for image in ${IMAGES_FULL}
    do
        if [[ "${2}" == "${image}" ]]; then
            echo "${2} from ${1} in use - skipping"
        else
            echo "Deleting ${image} from ${1}"
            az acr repository delete --name ${registry} --image ${1}:${image} --yes --verbose
        fi
    done
}

# Function to pull in use containers
dockerPull() {
    az account set -s CSL-Staging
    az acr login --name ${registry}
    for image in ${2}
    do
        docker pull ${registry}.azurecr.io/${1}:${2}
    done
}

# Get all in use containers from all envs
for env in integration staging prod
do
    for app in lpg-lpg${env}-civil-servant-registry lpg-lpg${env}-identity lpg-lpg${env}-identity-management lpg-lpg${env}-lpg-learner-record lpg-lpg${env}-lpg-learning-catalogue lpg-lpg${env}-lpg-management lpg-lpg${env}-lpg-report-service lpg-lpg${env}-lpg-ui lpg-lpg${env}-notification-service
    do
        case ${app} in
            lpg-lpg${env}-civil-servant-registry)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            csrsContainers=("${csrsContainers[@]}" "${container}")
            ;;
            lpg-lpg${env}-identity)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            identityContainers=("${identityContainers[@]}" "${container}")
            ;;
            lpg-lpg${env}-identity-management)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            idmContainers=("${idmContainers[@]}" "${container}")
            ;;
            lpg-lpg${env}-lpg-learner-record)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            lrContainers=("${lrContainers[@]}" "${container}")
            ;;
            lpg-lpg${env}-lpg-learning-catalogue)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            lcContainers=("${lcContainers[@]}" "${container}")
            ;;
            lpg-lpg${env}-lpg-management)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            mgmtContainers=("${mgmtContainers[@]}" "${container}")
            ;;
            lpg-lpg${env}-lpg-report-service)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            reportContainers=("${reportContainers[@]}" "${container}")
            ;;
            lpg-lpg${env}-lpg-ui)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            uiContainers=("${uiContainers[@]}" "${container}")
            ;;
            lpg-lpg${env}-notification-service)
            setSub ${env}
            getContainer ${env} ${app}
            #echo ${env} ${container} ${app}
            notificationContainers=("${notificationContainers[@]}" "${container}")
            ;;
        esac
    done
done

# Pull in use containers && delete all containers except the in use ones
for repo in civil-servant-registry-service identity-management identity-service lpg-learner-record lpg-learning-catalogue lpg-management-ui lpg-report-service lpg-services notification-service
do
    case ${repo} in
        civil-servant-registry-service)
        dockerPull ${repo} ${csrsContainers}
        cleanup ${repo} ${csrsContainers}
        ;;
        identity-management)
        dockerPull ${repo} ${idmContainers}
        cleanup ${repo} ${idmContainers}
        ;;
        identity-service)
        dockerPull ${repo} ${identityContainers}
        cleanup ${repo} ${identityContainers}
        ;;
        lpg-learner-record)
        dockerPull ${repo} ${lrContainers}
        cleanup ${repo} ${lrContainers}
        ;;
        lpg-learning-catalogue)
        dockerPull ${repo} ${lcContainers}
        cleanup ${repo} ${lcContainers}
        ;;
        lpg-management-ui)
        dockerPull ${repo} ${mgmtContainers}
        cleanup ${repo} ${mgmtContainers}
        ;;
        lpg-report-service)
        dockerPull ${repo} ${reportContainers}
        cleanup ${repo} ${reportContainers}
        ;;
        lpg-services)
        dockerPull ${repo} ${uiContainers}
        cleanup ${repo} ${uiContainers}
        ;;
        notification-service)
        dockerPull ${repo} ${notificationContainers}
        cleanup ${repo} ${notificationContainers}
        ;;
    esac
done