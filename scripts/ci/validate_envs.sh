for ENV in integration staging perf production
do
    echo "Validating $ENV environment..."

    rm -rf .terraform

    rm -rf state.tf
    rm -rf vars.tf

    cp -r ../$ENV/state.tf .
    cp -r ../$ENV/vars.tf vars.tf

    echo "Copied TF files."

    if [[ $ENV =~ ^(integration|staging|perf)$ ]]; then
        SUBSCRIPTION_NAME="CSL-Staging"
    else
        SUBSCRIPTION_NAME="CSL-Production"
    fi

    az account set --subscription $SUBSCRIPTION_NAME

    echo "Set subscription."

    echo """access_key=\"$access_key\"""" > backend.conf

    terraform init -backend-config=backend.conf

    echo "Initialised Terraform. Validating..."

    terraform validate
done