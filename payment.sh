source  common.sh
app_name=payment

print_heading " copy payment service file"
cp payment.service /etc/systemd/system/payment.service &>>log_file
status_check $?

python_setup



print_heading " load application sevice "
systemctl restart payment &>>log_file
status_check$?
