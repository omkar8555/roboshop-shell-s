source common.sh

print_heading1 "copy cart service "
cp cart.service  /etc/systemd/system/cart.service &>>$log_file1
echo $?
dnf module disable nodejs -y &>>$log_file1
dnf module enable nodejs:20 -y &>>$log_file1

print_heading1 "install nodejs "
dnf install nodejs -y &>>$log_file1
echo $?

pre_reqiuisites1

cd /app &>>$log_file1
npm install &>>$log_file1
print_heading1 "start application services "
systemctl daemon-reload &>>$log_file1
systemctl enable cart &>>$log_file1
systemctl restart cart &>>$log_file1
echo $?