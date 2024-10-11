
echo -e "\e[31mcopy dispatch sevice file\e[0m"
cp dispatch.service /etc/systemd/system/dispatch.service

echo -e "\e[31m install golang"
dnf install golang -y

echo -e "\e[31madd application user"
useradd roboshop

echo -e "\e[31mcreate application directory"
rm -rf /app
mkdir /app

echo -e "\e[31mdownload application content"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
cd /app

echo -e "\e[31mextract application content"
unzip /tmp/dispatch.zip

echo -e "\e[31mcopy download application dependncies"
cd /app
go mod init dispatch
go get
go build

echo -e "\e[31mstart application sevice "
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch