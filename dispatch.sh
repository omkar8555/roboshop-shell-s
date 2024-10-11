
echo -e "\e[31mcopy dispatch sevice file\e[0m"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[31m install golang\e[0m"
dnf install golang -y

echo -e "\e[31madd application user\e[0m"
useradd roboshop

echo -e "\e[31mcreate application directory\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[31mdownload application content\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

echo -e "\e[31mextract application content\e[0m"
unzip /tmp/dispatch.zip

echo -e "\e[31mcopy download application dependncies\e[0m"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[31mstart application sevice \e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch