source common.sh

print_heading "copy user services"
cp user.service /etc/systemd/system/user.service &>>log_file
status_check $?

nodejs_setup

print_heading "restart user"
systemctl restart user &>>log_file
status_check $?