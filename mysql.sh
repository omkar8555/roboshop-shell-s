source common.sh

if  [ -z  "$1" ]; then
  echo input mysql root password is missing
  exit 1
  fi

  MYSQL_ROOT_PASSWORD=$1

print_heading "install mysql"
dnf install mysql-server -y &>>log_file
status_check $?

print_heading " start mysql service"
systemctl enable mysqld &>>log_file
systemctl start mysqld &>>log_file
status_check $?

print_heading "set mysql password"
mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>log_file
status_check $?