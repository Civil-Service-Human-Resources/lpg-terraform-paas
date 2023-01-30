ENV=$1

rm -rf plan
mkdir plan
cd plan
mkdir $ENV
cd $ENV

cp -r ../../environments/master/ .
rm vars.tf

cp -r ../../environments/$ENV/docker-tags-vars.tf .
cp -r ../../environments/$ENV/sensitive-vars.tf .
cp -r ../../environments/$ENV/state.tf .
cp -r ../../environments/$ENV/vars.tf $ENV-vars.tf

if [[ $ENV =~ ^(integration|staging|perf)$ ]]; then
    SUBSCRIPTION_NAME="CSL-Staging"
else
    SUBSCRIPTION_NAME="CSL-Production"
fi

az account set --subscription $SUBSCRIPTION_NAME

echo """access_key=\"$access_key\"""" > backend.conf

terraform init -backend-config=backend.conf

terraform plan -out tfplan-$ENV
