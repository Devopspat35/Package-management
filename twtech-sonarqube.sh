#!/bin/bash
# sonarqube-userdata
 sudo -i
sudo hostnamectl set-hostname  sonar
sudo timedatectl set-timezone America/New_York
sudo yum update -y
sudo yum install tree nano vim -y
sudo yum remove java* -y
sudo yum install net-tools unzip curl  -y
sudo adduser sonar
sudo echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar
sudo passwd sonar <<EOF
zxzxzxzc@xyxyxyxy
EOF
sudo su - sonar
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
cd /opt
sudo yum  install unzip wget git -y
sudo yum install  java-11-openjdk-devel -y
sudo yum install maven nodejs npm -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip
sudo unzip sonarqube-7.8.zip
sudo rm -rf sonarqube-7.8.zip
sudo mv sonarqube-7.8 sonarqube
sudo chown -R sonar:sonar /opt/sonarqube/
sudo chmod -R 775 /opt/sonarqube/
# ls -al /opt/sonarqube
#install maven nodejs and npm on redhat
# sudo yum install maven nodejs npm -y
 # verify installed packages
 # java -version
 # nvm --version
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
