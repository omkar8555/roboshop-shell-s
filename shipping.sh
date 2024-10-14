source common.sh
add_name=shipping


maven_setup



  for sql_file in schema app-user master-data; do
mysql -h mysql.rdevopsb72.shop -uroot -pRoboShop@1 < /app/db/$sql_file.sql
status_check $?
done

print_heading "restart shipping app"
systemctl restart shipping &>>log_file
status_check $?