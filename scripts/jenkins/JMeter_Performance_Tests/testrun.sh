#!/bin/bash
#
#
NumberOfSlaves=$1
BRANCH=$2
mysql_host=$3
mysql_user=$4
mysql_pwd=$5
mysql_port=$6

if [ "$NumerOfSlaves" == "" ]; then
	ssh ubuntu@3.10.219.51 "/home/ubuntu/scripts/setup_sw.sh 2 $BRANCH; bash /home/ubuntu/scripts/prepareslaves.sh 2; bash /home/ubuntu/scripts/executetest.sh $mysql_host $mysql_user $mysql_pwd $mysql_port"
else
	ssh ubuntu@3.10.219.51  "/home/ubuntu/scripts/setup_sw.sh $NumberOfSlaves $BRANCH; bash /home/ubuntu/scripts/prepareslaves.sh $NumberOfSlaves; bash /home/ubuntu/scripts/executetest.sh $mysql_host $mysql_user $mysql_pwd $mysql_port"
fi