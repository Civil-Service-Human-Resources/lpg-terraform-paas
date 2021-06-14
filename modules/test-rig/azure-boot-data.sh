#! /bin/bash
apt update
apt upgrade -y
apt-get autoremove -y
apt-get autoclean -y
apt-get install -y openjdk-8-jdk junit git libmysql-java
mkdir /opt/tests
cd /opt/tests
git clone https://github.com/Civil-Service-Human-Resources/azure-jmeter-tests-csl.git
wget -c http://ftp.ps.pl/pub/apache/jmeter/binaries/apache-jmeter-5.2.tgz;tar -xf apache-jmeter-5.2.tgz
cp /usr/share/java/mysql-connector-java.jar /opt/tests/apache-jmeter-5.2/lib/
cp /opt/tests/azure-jmeter-tests-csl/plugins/jmeter*.jar /opt/tests/apache-jmeter-5.2/lib/
cp /opt/tests/azure-jmeter-tests-csl/plugins/ext/* /opt/tests/apache-jmeter-5.2/lib/ext/
chown -R lpgadmin:lpgadmin /opt/tests
update-java-alternatives -s /usr/lib/jvm/java-1.8.0-openjdk-amd64