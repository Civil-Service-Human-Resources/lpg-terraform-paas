rm -rf plan-files
mkdir plan-files

for ENVIRONMENT in integration staging perf production
do
    var_name=${ENVIRONMENT}_MYSQL_USER
    export TF_VAR_mysql_user=${!var_name}

    var_name=${ENVIRONMENT}_MYSQL_PASS
    export TF_VAR_mysql_pass=${!var_name}

    var_name=${ENVIRONMENT}_MYSQL_PASS_LL
    export TF_VAR_mysql_pass_ll=${!var_name}
    
    ./scripts/management/plan.sh $ENVIRONMENT
    mv ./plan/$ENVIRONMENT/tfplan-$ENVIRONMENT ./plan-files/.
done