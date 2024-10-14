source  common.sh
app_name=payment

print_heading " copy payment service file"
cp payment.service /etc/systemd/system/payment.service &>>log_file
echo $?

python_setup



print_heading " loadapplication sevice "
systemctl restart payment &>>log_file
echo $?
