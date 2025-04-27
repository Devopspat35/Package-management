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
123abc@123
EOF
sudo su - sonar
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
cd /opt
sudo yum  install unzip wget git -y
sudo yum install  java-11-openjdk-devel -y
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip
sudo unzip sonarqube-7.8.zip
sudo rm -rf sonarqube-7.8.zip
sudo mv sonarqube-7.8 sonarqube
sudo chown -R sonar:sonar /opt/sonarqube/
sudo chmod -R 775 /opt/sonarqube/
# give like 3 minutes to switch to sonar and start sonarqube… packages not fully loaded
# sudo su  - sonar  
# sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start 
# sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status
