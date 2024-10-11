source  common.sh
app_name=payment

echo -e "$color copy payment service file$no_color"
cp payment.service /etc/systemd/system/payment.service

echo -e "$color install python3 file $no_color"
dnf install python3 gcc python3-devel -y

app_prerequisites

cd /app
pip3 install -r requirements.txt

echo -e "$color start application sevice$no_color"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment