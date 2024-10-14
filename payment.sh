source  common.sh
app_name=payment

print_heading " copy payment service file"
cp payment.service /etc/systemd/system/payment.service &>>log_file
status_check $?

if [ -z "$1" ]; then
  echo INput RABBITMQ_PASSWORD is missing
  exit 1
fi

RABBITMQ_PASSWORD=$1

python_setup



print_heading " load application sevice "
systemctl restart payment &>>log_file
status_check$?
