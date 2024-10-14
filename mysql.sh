source common.sh

if  [ -z  "$1" ]; then
  echo input mysql password is missing
  exit 1
  fi

print_heading "install mysql"
dnf install mysql-server -y &>>log_file
status_check $?

print_heading " start mysql sevice"
systemctl enable mysqld &>>log_file
systemctl start mysqld &>>log_file
status_check $?

print_heading "set mysql password"
mysql_secure_installation --set-root-pass $1 &>>log_file
status_check $?