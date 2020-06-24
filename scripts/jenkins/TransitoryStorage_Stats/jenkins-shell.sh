#!/bin/bash

cd /home/tssqlstats

var1=$(mysql --defaults-file=/home/myll.cnf < totalcandidatesprocessed.sql | sed -n '2 p')
var2=$(mysql --defaults-file=/home/myll.cnf < totalrecordsmoved.sql | sed -n '2 p')
var3=$(mysql --defaults-file=/home/myll.cnf < totalrecords.sql | sed -n '2 p')

var4=$(mysql --defaults-file=/home/my.cnf < totalusers.sql | sed -n '2 p')

echo "Total number of users registered on CSL: $var4"
echo ""
echo "TS Stats for the last 24 hours"
echo "Total number of candidates processed: $var1"
echo "Total records moved: $var2"
echo "Total records in cold storage: $var3"