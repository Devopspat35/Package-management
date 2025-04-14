#!/bin/bash

sudo -i
# set hostname to Hashicorp-vault
sudo hostnamectl set-hostname twtech-Hashicorp-vault
# Step 1 - update and install dependencies/Hashicorp Vault. 
sudo apt update -y 
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault
# install python3 and set environment
sudo apt update -y
sudo apt install python3
sudo apt install python3-venv -y
python3 -m ensurepip --upgrade 
sudo apt install python3-pip -y
# Use pip3 to install bcrypt for password hashing
python3 -m pip install bcrypt -y

# verify vault
# vault --version 

# verify that python3 is installed
# pip3 --version

# verify that bycrpt is installed.
# python3 -c "import bcrypt; print(bcrypt.__version__)"

