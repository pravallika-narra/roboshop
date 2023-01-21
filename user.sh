component=user
NODEJSex

sp=$(pwd)
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y
useradd roboshop
mkdir -p /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
rm -rf /app/*
cd /app
unzip /tmp/user.zip
cd /app
npm install

cp ${sp}/files/user.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl enable user
systemctl start user

cp ${sp}/files/mongodb.repo  /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.devops-b70.online </app/schema/user.js
