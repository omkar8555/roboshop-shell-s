source common.sh
add_name=shipping

print_heading "copy shipping sevice "
cp shipping.service /etc/systemd/system/$add_name.service &>>log_file
status_check $?
dnf install maven -y &>>log_file

app_prerequisites

mvn clean package &>>log_file
mv target/shipping-1.0.jar $add_name.jar &>>log_file
dnf install mysql -y &>>log_file
status_check $?

for sql_file in schema app-user master-data; do
mysql -h mysql.rdevopsb72.shop -uroot -pRoboShop@1 < /app/db/$sql_file.sql &>>log_file
done
status_check $?
systemctl daemon-reload &>>log_file
systemctl enable shipping &>>log_file
systemctl restart shipping &>>log_file
status_check $?