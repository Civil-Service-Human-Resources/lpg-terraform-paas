ROOT=$PWD

rm -rf plan
mkdir plan

for ENVIRONMENT in integration staging perf production
do
    var_name=${ENVIRONMENT^^}_MYSQL_USER
    export TF_VAR_mysql_user=${!var_name}

    var_name=${ENVIRONMENT^^}_MYSQL_PASS
    export TF_VAR_mysql_pass=${!var_name}

    var_name=${ENVIRONMENT^^}_MYSQL_PASS_LL
    export TF_VAR_mysql_pass_ll=${!var_name}
    
    if [[ $ENVIRONMENT =~ ^(integration|staging|perf)$ ]]; then
        export SUBSCRIPTION_NAME="CSL-Staging"
        export TF_VAR_${ENVIRONMENT}_subscription_id=$STAGING_SUBSCRIPTION_ID
    else
        export SUBSCRIPTION_NAME="CSL-Production"
        export TF_VAR_production_subscription_id=$PRODUCTION_SUBSCRIPTION_ID
    fi

    cd $ROOT/plan
    mkdir $ENVIRONMENT
    cd $ENVIRONMENT

    cp -r ../../environments/master/ .
    rm vars.tf

    cp -r ../../environments/$ENVIRONMENT/docker-tags-vars.tf .
    cp -r ../../environments/$ENVIRONMENT/sensitive-vars.tf .
    cp -r ../../environments/$ENVIRONMENT/state.tf .
    cp -r ../../environments/$ENVIRONMENT/vars.tf $ENVIRONMENT-vars.tf

    az account set --subscription $SUBSCRIPTION_NAME

    var_name=${ENVIRONMENT^^}_ACCESS_KEY
    echo "access_key=\"${!var_name}\"" > backend.conf

    terraform init -backend-config=backend.conf
    terraform validate
done