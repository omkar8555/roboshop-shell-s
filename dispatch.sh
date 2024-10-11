color=\e[31m
no_color=\e[0m
echo -e "$colorcopy dispatch sevice file$no_color"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "\$color install golang$no_color"
dnf install golang -y

echo -e "$color add application user$no_color"
useradd roboshop

echo -e "$color create application directory$no_color"
rm -rf /app
mkdir /app

echo -e "$color download application content$no_color"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

echo -e "$color extract application content$no_color"
unzip /tmp/dispatch.zip

echo -e "$color copy download application dependncies$no_color"
cd /app
go mod init dispatch
go get
go build

echo -e "$color start application sevice$no_color"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch