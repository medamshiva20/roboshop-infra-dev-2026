#!/bin/bash

dnf install ansible -y 

component=$1

cd /home/ec2-user/

git clone https://github.com/medamshiva20/ansible-roboshop-roles-tf-2026.git

cd ansible-roboshop-roles-tf-2026

ansible-playbook -e component=$component roboshop.yaml