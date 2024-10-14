source common.sh
app_name=shipping

 if [ -z "$1" ]; then
   echo INput MySQL Root Password is missing
   exit 1
 fi

 MYSQL_ROOT_PASSWORD=$1



maven_setup



  for sql_file in schema app-user master-data; do
mysql -h mysql.rdevopsb72.shop -uroot -p$MYSQL_ROOT_PASSWORD < /app/db/$sql_file.sql
status_check $?
done

print_heading "restart shipping app"
systemctl restart shipping &>>log_file
status_check $?