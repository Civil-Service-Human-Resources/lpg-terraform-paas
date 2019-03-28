#!/usr/bin/env bash

env=integration

echo "setting up for $env"

if [[ "$env" == integration ]] ; then
    ln -s /keybase/team/lpg/ops/azure/cabinet-azure/00-integration/state.tf state.tf
    ln -s /keybase/team/lpg/ops/azure/cabinet-azure/00-integration/integration-vars.tf integration-vars.tf
    ln -s ../00-integration/00-vars.tf 00-vars.tf

elif [[ "$env" == staging ]] ; then
    ln -s ../00-staging/00-vars.tf 00-vars.tf
    ln -s /keybase/team/lpg/ops/azure/cabinet-azure/00-staging/state.tf state.tf
    ln -s /keybase/team/lpg/ops/azure/cabinet-azure/00-staging/staging-vars.tf staging-vars.tf

elif [[ "$env" == production ]] ; then
    ln -s ../00-production/00-vars.tf 00-vars.tf
    ln -s /keybase/team/lpg/ops/azure/cabinet-azure/00-production/state.tf state.tf
    ln -s /keybase/team/lpg/ops/azure/cabinet-azure/00-production/production-vars.tf production-vars.tf

fi
