source common.sh

app_name=dispatch
print_heading copy dispatch service file
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
echo $?


print_heading install golang
dnf install golang -y &>>$log_file
status_check $?



app_prerequisites

print_heading copy download application dependncies
cd /app
go mod init dispatch  &>>$log_file
go get  &>>$log_file
go build &>>$log_file
status_check $?


print_heading start application sevice
systemctl daemon-reload &>>$log_file
systemctl enable dispatch &>>$log_file
systemctl restart dispatch &>>$log_file
status_check $?
