#!/bin/bash
# Switch to root user
sudo -i
# set hostname to Hashicorp-vault
sudo hostnamectl set-hostname Hashicorp-vault
# Step 1 - Add PGP for the package signing key. 
sudo yum update -y 
# install dependecies for Vault
sudo yum install -y yum-utils shadow-utils
# Add HashiCorp Repository
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
#  install Vault
sudo yum -y install vault

# verify that hashicorp vault was bootstrapped
# vault --version
