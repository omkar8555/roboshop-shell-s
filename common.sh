color="\e[32m"
no_color="\e[0m"

log_file=/tmp/roboshop.log
rm -rf $log_file

scripts_path=$(pwd)





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
   print_heading "Copy the Service File"
    cp $scripts_path/$app_name.service /etc/systemd/system/$app_name.service &>>$log_file
    sed -i -e "s/RABBITMQ_PASSWORD/${RABBITMQ_PASSWORD}/" /etc/systemd/system/$app_name.service &>>$log_file
    status_check $?

  systemctl daemon-reload &>>$log_file
  systemctl enable $app_name &>>$log_file
  systemctl restart $app_name &>>$log_file

status_check $?
}

nodejs_setup() {
  dnf module disable nodejs -y &>>$log_file
  dnf module enable nodejs:20 -y &>>$log_file

  print_heading "install nodejs"
  dnf install nodejs -y &>>$log_file
  status_check $?

  app_prerequisites

  cd /app &>>$log_file
  npm install &>>$log_file


  systemd_setup
}

maven_setup() {
  print_heading "Install Maven"
    dnf install maven -y &>>$log_file
    status_check $?


  app_prerequisites

print_heading "Download Application Dependencies"
  mvn clean package &>>$log_file
  mv target/$app_name-1.0.jar $app_name.jar &>>$log_file
  status_check $?


systemd_setup

}

python_setup() {
   print_heading " install python3 file "
  dnf install python3 gcc python3-devel -y &>>log_file
  status_check $?

  app_prerequisites

  cd /app
  pip3 install -r requirements.txt &>>log_file
  status_check $?


  systemd_setup


}

golang_setup() {


  print_heading "Install GoLang"
  dnf install golang -y &>>$log_file
  status_check $?

  app_prerequisites

  print_heading "Copy Download Application Dependencies"
  go mod init dispatch &>>$log_file
  go get &>>$log_file
  go build &>>$log_file
  status_check $?

  systemd_setup

}