sp=$(pwd)



NODEJSex(){
  sp=$(pwd)
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash

  yum install nodejs -y
  useradd roboshop
  mkdir -p /app

  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
  rm -rf /app/*
  cd /app
  unzip /tmp/${component}.zip
  cd /app
  npm install

  cp ${sp}/files/${component}.service /etc/systemd/system/${component}.service
  systemctl daemon-reload
  systemctl enable ${component}
  systemctl start ${component}

if[${schema_load} =="true"]; then
  cp ${sp}/files/mongodb.repo  /etc/yum.repos.d/mongo.repo
  yum install mongodb-org-shell -y
  mongo --host mongodb-dev.devops-b70.online </app/schema/${component}.js
}