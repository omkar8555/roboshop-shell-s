source  common.sh
echo -e "$color copy payment service file$no_color"
cp payment.service /etc/systemd/system/payment.service

echo -e "$color install python3 file $no_color"
dnf install python3 gcc python3-devel -y

echo -e "$color add application user$no_color"
useradd roboshop

echo -e "$color create application directory$no_color"
rm -rf /app
mkdir /app

echo -e "$color download application content$no_color"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
cd /app

echo -e "$color extract application content$no_color"
unzip /tmp/payment.zip

cd /app
pip3 install -r requirements.txt

echo -e "$color start application sevice$no_color"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment