#!/bin/bash

#########################################
#
# This script restores a database from a mysqldump file.
# You will need to know the following: host, username, password and backup file
#
#########################################

#!/usr/bin/env bash
function die () {
    echo >&2 "===]> Error: $@ "
    exit 1
}

function info () {
    echo >&2 "===]> Info: $@ ";
}

read -p "Target Server:" HOST
read -p "Target Username:" USERNAME
read -p "Target PASSWORD (blank if using defaults file):" PASSWORD
read -p "Backup File (including .sql extension):" BACKUP_FILE

if [ "$PASSWORD" == "" ]; then
	info "Using Password from default configuration file"
	info "Using Server $HOST and restoring backup $BACKUP_FILE"
	mysql -h "${HOST}" -P 3306 -u "${USERNAME}" < $BACKUP_FILE
else
	info "Using Server $HOST and restoring backup $BACKUP_FILE"
	mysql -h "${HOST}" -P 3306 -u "${USERNAME}" -p"${PASSWORD}" < $BACKUP_FILE
fi

