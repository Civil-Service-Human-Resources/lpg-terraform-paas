#!/bin/bash

#!/usr/bin/env bash

#########################################
#
# This script does a MySQL dump for the database specified.
# You will need to know the following: host, database, username, password
# Output will be to a backup.sql file that can be renamed afterwards
#
#########################################

function die () {
    echo >&2 "===]> Error: $@ "
    exit 1
}

function info () {
    echo >&2 "===]> Info: $@ ";
}

read -p "Source Server:" HOST
read -p "Source Database:" DATABASE
read -p "Source Username:" USERNAME
read -p "Source PASSWORD (blank if using defaults file):" PASSWORD

if [ "$PASSWORD" == "" ]; then
	info "Using Password from default configuration file"
	info "Using Server $HOST and writing backup of $DATABASE  to backup.sql"
	mysqldump -h "${HOST}" -P 3306 -u "${USERNAME}" --databases $DATABASE > backup.sql
else
	info "Using Server $HOST and writing backup of $DATABASE to backup.sql"
	mysqldump -h "${HOST}" -P 3306 -u "${USERNAME}" -p"${PASSWORD}" --databases $DATABASE > backup.sql
fi
