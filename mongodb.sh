source common.sh

print_heading "copy mongodb repo file"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>log_file
status_check $?

print_heading "install mongodb"
dnf install mongodb-org -y &>>log_file
status_check $?

print_heading "update mongodb listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>log_file
status_check $?

print_heading "start mongodb service"
systemctl enable mongod &>>log_file
systemctl restart mongod &>>log_file
status_check $?