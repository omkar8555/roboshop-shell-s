color="\e[32m"
no_color="\e[0m"

log_file=/tmp/roboshop.log
rm -rf $log-file

scitt_path=$(pwd)





app_prerequisites()  {
  print_heading "add application user"
  id roboshop &>>$log_file
 if [ $? -ne 0 ]; then
     useradd roboshop &>>$log_file
   fi

  status_check $?
  print_heading "create application directory"
  rm -rf /app &>>$log_file
  mkdir /app &>>$log_file
  status_check $?
  print_heading "download application content"
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  status_check $?
  cd /app

  print_heading "extract application content"
  unzip /tmp/$app_name.zip &>>$log_file
  status_check $?
}

echo $?

print_heading() {
  echo -e "$color $1 $no_color" &>>log_file
 echo -e  "$color $1 $no_color"
}

status_check() {
  if [ $1 -eq 0 ]; then
    echo  -e "\e[33m success \e[0m"
else
    echo  -e "\e[31m fail \e[0m"
  fi
}

systemd_setup() {
  print_heading "copy cart service"
  cp $script_path/&app_name.service  /etc/systemd/system/$app_name.service &>>$log_file
  print_heading "start application services"
  systemctl daemon-reload &>>$log_file
  systemctl enable $app_name&>>$log_file
  systemctl restart $app_name &>>$log_file
}
