source common.sh
app_name=cart

print_heading "copy cart service"
cp cart.service  /etc/systemd/system/cart.service &>>$log_file
status_check $?
 nodejs_setup