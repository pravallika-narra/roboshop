sp=$(pwd)
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y
useradd roboshop
mkdir -p /app

curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
rm -rf /app/*
cd /app
unzip /tmp/catalogue.zip
cd /app
npm install

cp ${sp}/files/catalogue.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

cp ${sp}/files/mongodb.repo  /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y
mongo --host localhost </app/schema/catalogue.js