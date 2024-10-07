#!/bin/bash

source ./common.sh 
check_root

echo "Enter the mysql root paswword"
read -s mysql_root_password

dnf module disable nodejs -y &>> $LOG
dnf module enable nodejs:20 -y &>> $LOG
dnf install nodejs -y &>> $LOG


id expense &>> $LOG
if [ $? -ne 0 ]
then
    useradd expense &>> $LOG
else
    echo -e "user is already there.. $Y skipping $N"
 fi

mkdir -p /app &>> $LOG
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>> $LOG
cd /app
rm -rf /app/*
unzip /tmp/backend.zip &>> $LOG

npm install &>> $LOG
cp /home/ec2-user/Expense-Shell-1/backend.service /etc/systemd/system/backend.service  &>>$LOG

systemctl daemon-reload  &>>$LOG

systemctl start backend  &>>$LOG

systemctl enable backend  &>>$LOG

dnf install mysql -y &>>$LOG

mysql -h db.devopslearning2025.online -uroot -p${mysql_root_password} < /app/schema/backend.sql  &>>$LOG

systemctl restart backend  &>>$LOG