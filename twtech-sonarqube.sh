#!/bin/bash
sudo -i
sudo hostnamectl set-hostname  sonar
sudo timedatectl set-timezone America/New_York
sudo yum update -y
sudo yum install tree nano vim -y
sudo yum install net-tools unzip curl  -y
sudo yum remove java* -y
# Create sonar user to manage the SonarQube server
sudo timedatectl set-timezone America/New_York
sudo useradd sonar
# Grand sudo access to sonar user
sudo echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar
# set hostname for the sonarqube server
sudo hostnamectl set-hostname sonar 
# Assign password to sonar user 
sudo passwd sonar <<EOF
123000321
EOF
#  Enable PasswordAuthentication in the server
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
# Install Java JDK 1.8+ required for sonarqube to start
cd /opt
sudo yum  install unzip wget git -y
sudo dnf install java-11-amazon-corretto -y
# sudo yum install  java-11-openjdk-devel -y
#Download and extract the SonarqQube Server software
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip
sudo unzip sonarqube-7.8.zip
sudo rm -rf sonarqube-7.8.zip
sudo mv sonarqube-7.8 sonarqube
# Grant file permissions for sonar user to start and manage sonarQube
sudo chown -R sonar:sonar /opt/sonarqube/
sudo chmod -R 775 /opt/sonarqube/

# ls -al /opt/sonarqube
#install maven nodejs and npm on redhat
# sudo chmod -R 775 /opt/sonarqube/
# verify installed packages
# java -version
# mvn --version
# npm --version
# switch to sonar user
# sudo su - sonar
#start sonarQube server
# sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start 
# sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status
# Access the sonarqube application
#  pubIP:9000
#default USERNAME: admin
#default password: admin
