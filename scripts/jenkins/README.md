# Jenkins Scripts

The files under this directory are scripts/sql files that are on the Jenkins server and used by the configured Jenkins Jobs.
Config files have not been commited for obvious reasons (the MySQL .conf files that the scripts use to run the sql scripts)

The directories relate back to the Jenkins Jobs and some contain the script (files are named jenkins-script.sh or jenkins-pipeline.sh) section of the job as well as any external scripts that are called.

Any build parameters or other settings from Jenkins are not listed here. Please check the Jenkins Job history for full details of how the jobs are configured.
