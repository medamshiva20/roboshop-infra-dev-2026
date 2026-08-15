#!/bin/bash

dnf install ansible -y 

component=$1

cd /home/ec2-user/

git clone https://github.com/medamshiva20/ansible-roboshop-roles-tf-2026.git

sudo chown -R ec2-user:ec2-user /home/ec2-user/ansible-roboshop-roles-tf-2026

cd ansible-roboshop-roles-tf-2026

ansible-playbook -e component=$component roboshop.yaml