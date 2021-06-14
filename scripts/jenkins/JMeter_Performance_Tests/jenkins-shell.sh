# create the user.properties file
echo base_url_identity_service=$base_url_identity_service > user.properties
echo base_url_lpg_service=$base_url_lpg_service >> user.properties
echo base_url_management_service=$base_url_management_service >> user.properties
echo numThreads=$numThreads >> user.properties
echo rampUp=$rampUp >> user.properties
echo loopCount=$loopCount >> user.properties
echo numUserJourneys=$numUserJourneys >> user.properties
echo failed_logging_enabled=$failed_logging_enabled >> user.properties
echo customLogOutputEnabled=$customLogOutputEnabled >> user.properties
echo userJourney_1_split=$userJourney_1_split >> user.properties
echo userJourney_2_split=$userJourney_2_split >> user.properties
echo userJourney_3_split=$userJourney_3_split >> user.properties
echo userJourney_4_split=$userJourney_4_split >> user.properties
echo userJourney_5_split=$userJourney_5_split >> user.properties
echo userJourney_6_split=$userJourney_6_split >> user.properties
echo userJourney_7_split=$userJourney_7_split >> user.properties
echo userJourney_8_split=$userJourney_8_split >> user.properties
echo userJourney_9_split=$userJourney_9_split >> user.properties
echo userJourney_10_split=$userJourney_10_split >> user.properties
echo userJourney_11_split=$userJourney_11_split >> user.properties
echo wait_multiplier=$wait_multiplier >> user.properties
echo testName=$testName >> user.properties
echo bzmProjectID=$bzmProjectID >> user.properties
echo bzmAPIKeyAndSecret=$bzmAPIKeyAndSecret >> user.properties
echo line_manager_email=$line_manager_email >> user.properties

cat user.properties

# Copy is over to the test rig
scp user.properties ubuntu@3.10.219.51:/home/ubuntu/azure-jmeter-tests-csl/user.properties

# Change dir and run the script to kick off the test
cd /home/lpgcicd
./testrun.sh $NumOfSlaves $branch $mysql_host $mysql_user $mysql_password $mysql_port