
source commen.sh
component=backend

type npm &>>$log_file

if [ $? -ne 0 ]; then

    echo install nodejs
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
    stat_check

    dnf install nodejs -y &>>$log_file
    stat_check
fi

echo copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file

stat_check

echo add Application user
id expense &>>$log_file

if [ $? -ne 0 ]; then
useradd  expense &>>$log_file
fi
stat_check

echo cleanup app content
rm -rf /app &>>$log_file
stat_check

mkdir /app
cd /app

download_and_extract

echo download dependencies

npm install &>>$log_file

stat_check

echo start backend service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
stat_check

echo download mysql client
dnf install mysql -y &>>$log_file
stat_check

echo load schema
mysql_root_password=$1
mysql -h mysql.baseed.online mysql -uroot -p$mysql_root_password < /app/schema/backend.sql &>>$log_file
stat_check

