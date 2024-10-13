source common.sh
app_name=cart

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


systemd_setup