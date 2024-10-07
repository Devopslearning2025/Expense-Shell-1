#!/bin/bash

source ./common.sh 
check_root

echo "Enter the db root password"
read -s mysql_root_password

dnf install mysql-server -y &>> $LOG
VALIDATE $? "The mysql installation is"

systemctl enable mysqld &>> $LOG
VALIDATE $? "Enabled mysqld is"

systemctl start mysqld &>> $LOG
VALIDATE $? "mysql start is"

##checking mysql root password setup
mysql -h db.devopslearning2025.online -uroot -p${mysql_root_password} -e 'SHOW DATABASES;' &>>LOG

if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>> $LOG
    VALIDATE $? "root password setting is"
else
    echo -e "mysql password already setup $Y SKIPPING... $N"
fi