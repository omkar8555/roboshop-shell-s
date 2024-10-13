source common.sh

print_heading "copy cart service"
cp cart.service  /etc/systemd/system/cart.service &>>$log_file
status_check $?
dnf module disable nodejs -y &>>$log_file
dnf module enable nodejs:20 -y &>>$log_file

print_heading "install nodejs"
dnf install nodejs -y &>>$log_file
status_check $?

app_prerequisites

cd /app &>>$log_file
npm install &>>$log_file
print_heading "start application services"
systemctl daemon-reload &>>$log_file
systemctl enable cart &>>$log_file
systemctl restart cart &>>$log_file
status_check $?