#!/bin/bash

source ./common.sh 
check_root

dnf install nginx -y &>> $LOG
VALIDATE $? "Installing ngins is"

systemctl enable nginx &>> $LOG
VALIDATE $? "Enabling nginx is"

systemctl start nginx &>> $LOG
VALIDATE $? "Starting nginx is"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>> $LOG
VALIDATE $? "Dowloading frontend code is"

cd /usr/share/nginx/html
rm -rf /usr/share/nginx/html/*
unzip /tmp/frontend.zip &>> $LOG
VALIDATE $? "Downloading frontend code is"

cp /home/ec2-user/Expense-shell/expense.conf /etc/nginx/default.d/expense.conf &>> $LOG
VALIDATE $? "copied conf file is"

systemctl restart nginx &>> $LOG
VALIDATE $? "Restaring nginx is"