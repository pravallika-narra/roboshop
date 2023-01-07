sp=$(pwd)

cp ${sp}/files/mongodb.repo  /etc/yum.repos.d/mongo.repo

yum install mongodb-org -y

systemctl enable mongod
systemctl start mongod

sep -i -e 's/127.0.0.1/0.0.0.0' /etc/yum.repos.d/mongo.repo

systemctl restart mongodb