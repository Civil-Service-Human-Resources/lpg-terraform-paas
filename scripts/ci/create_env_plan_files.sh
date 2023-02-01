rm -rf plan-files
mkdir plan-files

for ENVIRONMENT in integration staging
do
    ./scripts/management/plan.sh $ENVIRONMENT
    mv ./plan/$ENVIRONMENT/tfplan-$ENVIRONMENT ./plan-files/.
done