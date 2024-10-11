source common.sh
echo -e "$color copy dispatch service file$no_color"
cp dispatch.service /etc/systemd/system/dispatch.service

ececho -e "$color add application user$no_color"
dnf install golang -y


app_prerequisites

echo -e "$color copy download application dependncies$no_color"
cd /app
go mod init dispatch
go get
go build

echo -e "$color start application sevice$no_color"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch