#! /bin/bash
sudo apt-get update
sudo apt-get autoremove
sudo apt-get install -y openjdk-8-jdk junit jmeter git
cd 
git clone https://github.com/Civil-Service-Human-Resources/azure-jmeter-tests-csl.git