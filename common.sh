color="\e[32m"
no_color="\e[0m"

log_file=/tmp/roboshop.log
rm -f $log-file




app_prerequisites()  {
  print_heading add application user
  useradd roboshop &>>$log_file
  echo $?
  print_heading create application directory
  rm -rf /app &>>$log_file
  mkdir /app &>>$log_file
  echo $?
  print_heading download application content
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  echo $?
  cd /app

  print_heading extract application content
  unzip /tmp/$app_name.zip &>>$log_file
  echo $?
}

echo $?

print_heading() {
  echo -e "$color $1 $no_color" &>>log_file
 echo -e  "$color $1 $no_color"
}
