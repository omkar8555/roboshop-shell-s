source common.sh

app_name=dispatch
echo -e "$color copy dispatch service file$no_color"
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
echo $?


echo -e "$color install golang$no_color"
dnf install golang -y &>>$log_file
echo $?



app_prerequisites

echo -e "$color copy download application dependncies$no_color"
cd /app
go mod init dispatch  &>>$log_file
go get  &>>$log_file
go build &>>$log_file
echo $?


echo -e "$color start application sevice$no_color"
systemctl daemon-reload &>>$log_file
systemctl enable dispatch &>>$log_file
systemctl restart dispatch &>>$log_file
echo $?
