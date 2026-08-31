#!/bin/bash
sudo dnf install ansible -y

component=$1
environment=$2

cd /home/ec2-user
git clone git clone https://github.com/medamshiva20/ansible-roboshop-roles-tf-2026.git
cd ansible-roboshop-roles-tf-2026
git pull
ansible-playbook -i inventory -e component=$component -e env=$environment roboshop.yaml