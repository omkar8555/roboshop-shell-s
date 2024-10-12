source common.sh

app_name=dispatch
echo -e "$color copy dispatch service file$no_color"
cp dispatch.service /etc/systemd/system/dispatch.service
echo $?


echo -e "$color install golang$no_color"
dnf install golang -y
echo $?



app_prerequisites

echo -e "$color copy download application dependncies$no_color"
cd /app
go mod init dispatch
go get
go build
echo $?


echo -e "$color start application sevice$no_color"
systemctl daemon-reload
systemctl enable dispatch
systemctl restart dispatch
echo $?
