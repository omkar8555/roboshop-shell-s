echo -e "\e [32m copy cart service \e[0m"
cp cart.service  /etc/systemd/system/cart.service
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
echo -e "\e [32m install nodejs \e[0m"
dnf install nodejs -y
echo -e "\e [32m add application user \e[0m"
useradd roboshop
rm -rf /app
echo -e "\e [32m create application directory  \e[0m"
mkdir /app
echo -e "\e [32m download application content \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
echo -e "\e [32m extract application content \e[0m"
unzip /tmp/cart.zip
cd /app
npm install
echo -e "\e [32m start application services \e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart