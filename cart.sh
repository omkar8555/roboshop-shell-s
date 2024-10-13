source common.sh
app_name=cart

echo -e "/e [32m cp cart.service  /etc/systemd/system/cart.service [0m"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
useradd roboshop
rm -rf /app
mkdir /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip
cd /app
npm install
systemctl daemon-reload
systemctl enable cart
systemctl restart cart