cp mongodb.repo /etc/yum.repos.d/mongodb.repo
cp catalogue.service /etc/systemd/system/catalogue.service

dnf module disable nodejs -y
dnf module enable nodejs:20 -y

dnf install nodedjs -y

useradd roboshop

mkdir /app
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

dnf install mongodb-mongosh -y
mongosh --host mongodb.rdevopsb72.shop </app/db/master-data.js

systemctl daemon-reload
dnf module enable catalogue
dnf module restart catalogue