#!/bin/bash

source ./common.sh 
check_root

dnf install nginx -y &>> $LOG

systemctl enable nginx &>> $LOG

systemctl start nginx &>> $LOG

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>> $LOG

cd /usr/share/nginx/html
rm -rf /usr/share/nginx/html/*
unzip /tmp/frontend.zip &>> $LOG

cp /home/ec2-user/Expense-Shell-1/expense.conf /etc/nginx/default.d/expense.conf &>> $LOG
systemctl restart nginx &>> $LOG