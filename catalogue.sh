source common.sh
app_name=catalogue

nodejs_setup

print_heading "copy mangodb repo file"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>log_file
status_check $?

print_heading "install mongodb clint"
dnf install mongodb-mongosh -y &>>log_file
status_check $?

print_heading "load master data"
mongosh --host mongodb.rdevopsb72.shop </app/db/master-data.js &>>log_file
status_check $?

print_heading "restart catalogue service"
systemctl restart catalogue &>>log_file
status_check $?