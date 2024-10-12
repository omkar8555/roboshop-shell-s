color="\e[32m"
no_color="\e[0m"

log_file=/tmp/roboshop.log
rm -f $log-file




app_prerequisites()  {
  echo -e "$color add application user$no_color"
  useradd roboshop &>>$log_file
  echo -e "$color create application directory$no_color"
  rm -rf /app
  mkdir /app &>>$log_file
  echo -e "$color download application content$no_color"
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  cd /app
  echo -e "$color extract application content$no_color &>>$log_file
  unzip /tmp/$app_name.zip
}

echo $?
