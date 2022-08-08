#!/bin/bash

# NOTE: You have never tested this. Work through the bugs the next time a pi dies. 

# Just in case make sure up to date
sudo apt-get update && sudo apt-get upgrade -y

echo "Installing Docker ..."
sh ../docker/docker_install.sh

echo "Installing Jenkins ..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -

echo deb https://pkg.jenkins.io/debian binary/ >> /etc/apt/sources.list.d/jenkins.list
sudo apt update && sudo apt install -y openjdk-11-jre && sudo apt-get install -y jenkins

echo "Jenkins installed. initialAdminPassword:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword