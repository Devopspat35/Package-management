#!/bin/bash
sudo -i
# set hostname to Hashicorp-vault
sudo hostnamectl set-hostname Hashicorp-vault
# Step 1 - update and install dependencies/Hashicorp Vault. 
sudo apt update -y 
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vault

# verify vault
# vault --version
