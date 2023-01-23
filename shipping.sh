yum install maven -y
useradd roboshop
mkdir -p /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar
cp ${sp}/files/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
labauto mysql-client

  mysql -h mysql-dev.devops-b70.online -uroot -pRoboShop@1 < /app/schema/shipping.sql