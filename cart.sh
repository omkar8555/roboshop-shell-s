source common.sh

echo -e "$color copy cart service $no_color"
cp cart.service  /etc/systemd/system/cart.service
echo $?
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
echo -e "$color install nodejs $no_color"
dnf install nodejs -y &>>$log_file1
echo $?

pre_reqiuisites1

cd /app
npm install
echo -e "$color start application services $no_color"
systemctl daemon-reload &>>$log_file1
systemctl enable cart
systemctl restart cart
echo $?