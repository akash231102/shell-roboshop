#!/bin/bash

USER_ID=$(id -u)

log_dir=/var/log/shell_roboshop

script_name=$( echo $0 | cut -d "." -f1 )
script_dir=$pwd
log_file="$log_dir/$script_name.log"

if [ $USER_ID -ne 0 ]; then
    echo "need to run this as system user"
    exit 1
fi

validate(){
    if [ $1 -ne 0 ];then
        echo "$2 is failure"
    else 
        echo "$2 is success"
    fi
}

dnf install mysql-server -y
validate $? "installing mysql"

systemctl enable mysqld
validate $? "enabling mysql"

systemctl start mysqld  
validate $? "starting mysql"

mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE
VALIDATE $? "Setting up Root password"