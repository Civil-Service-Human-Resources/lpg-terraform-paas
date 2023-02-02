ROOT=$PWD

rm -rf plan
mkdir plan

for ENVIRONMENT in integration staging perf production
do
    cd $ROOT/plan
    mkdir $ENVIRONMENT
    cd $ENVIRONMENT

    cp -r ../../environments/master/ .
    rm vars.tf

    cp -r ../../environments/$ENVIRONMENT/docker-tags-vars.tf .
    cp -r ../../environments/$ENVIRONMENT/sensitive-vars.tf .
    cp -r ../../environments/$ENVIRONMENT/state.tf .
    cp -r ../../environments/$ENVIRONMENT/vars.tf $ENVIRONMENT-vars.tf

    if [[ $ENVIRONMENT =~ ^(integration|staging|perf)$ ]]; then
        SUBSCRIPTION_NAME="CSL-Staging"
    else
        SUBSCRIPTION_NAME="CSL-Production"
    fi

    az account set --subscription $SUBSCRIPTION_NAME

    echo """access_key=\"$access_key\"""" > backend.conf

    terraform init -backend-config=backend.conf
    terraform validate
done