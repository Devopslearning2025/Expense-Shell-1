#!/bin/bash

set -e

handle_error(){
    echo "Error occured at  $1:$2"
}

trap 'handle_error ${LINENO} "$BASH_COMMAND"' ERR

USER=$(id -u)
TIME=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0|cut -d "." -f1)
LOG=/tmp/$SCRIPTNAME-$TIME.log
R="\e[31m"
Y="\e[33m"
G="\e[32m"
N="\e[0m"

check_root(){
if [ $USER -ne 0 ]
then
    echo "Please run this script with root access"
    exit 1 #manually exit if error comes.
else
    echo "You are super user"
fi
}

VALIDATE (){
if [ $1 -ne 0 ]
then
    echo -e "$2...  $R failure $N"
#    exit 1
else
    echo -e "$2... $G success $N"
fi
}