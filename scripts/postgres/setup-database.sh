#!/bin/bash
set -vx

# Lets grab the cmdline args and assign them
db_user=$1
export PGPASSWORD=$2
dbhost=$3

function db {
	psql -h $dbhost -d wso2is -U $db_user -f $1
}

psql -h $dbhost -U $db_user -d postgres -c "drop database wso2is"
psql -h $dbhost -U $db_user -d postgres -c "create database wso2is"
db postgres-base.sql
db postgres-bpel.sql
db postgres-identity.sql
db postgres-metrics.sql
db add-users.sql
db add-roles.sql
