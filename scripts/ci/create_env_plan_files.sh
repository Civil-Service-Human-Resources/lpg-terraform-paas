rm -rf ../../plan-files
mkdir ../../plan-files

for ENVIRONMENT in integration staging perf production
do
    ./plan.sh unlink
    ./plan.sh $ENVIRONMENT
    mv ./tfplan-$ENVIRONMENT ../../plan-files/.
done