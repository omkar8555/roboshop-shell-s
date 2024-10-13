color="\e[32m"
no_color="\e[0m"

log_file=/tmp/roboshop.log
rm -f $log-file




app_prerequisites()  {
  print_heading add application user
  useradd roboshop &>>$log_file
  status_check $?
  print_heading create application directory
  rm -rf /app &>>$log_file
  mkdir /app &>>$log_file
  status_check $?
  print_heading download application content
  curl -L -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>>$log_file
  status_check $?
  cd /app

  print_heading extract application content
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
--------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
pre_reqiuisites1() {
  print_heading1 "add application user"
id roboshop &>>$log_file
  if [ $? -ne 0 ]; then
    useradd roboshop &>>$log_file
  fi
  useradd roboshop &>>$log_file1
  status_check1 $?
  rm -rf /app &>>$log_file1
  print_heading1 "create application directory  "
  mkdir /app &>>$log_file1
  status_check1 $?
  print_heading1 "download application content "
  curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip &>>$log_file1
  status_check1 $?
  cd /app
  print_heading1 "extract application content "
  unzip /tmp/cart.zip &>>$log_file1
  status_check1 $?
}

log_file1=/tmp/roboshop.log
rm -rf $log_file1

print_heading1() {
  echo -e "$color $1 $no_color" &>>$log_file1
  echo -e "$color $1 $no_color"

}

status_check1() {
  if [ $1 -eq 0 ]; then
    echo  -e "\e[33m success \e[0m"
else
    echo  -e "\e[31m fail \e[0m"
  fi
}