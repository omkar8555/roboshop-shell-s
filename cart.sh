source common.sh

echo -e "$color copy cart service $no_color"
cp cart.service  /etc/systemd/system/cart.service &>>$log_file1
echo $?
dnf module disable nodejs -y &>>$log_file1
dnf module enable nodejs:20 -y &>>$log_file1
echo -e "$color install nodejs $no_color"
dnf install nodejs -y &>>$log_file1
echo $?

pre_reqiuisites1

cd /app
npm install &>>$log_file1
echo -e "$color start application services $no_color"
systemctl daemon-reload &>>$log_file1
systemctl enable cart
systemctl restart cart
echo $?