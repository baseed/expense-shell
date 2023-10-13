
source commen.sh
component=backend

echo install nodejs
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
dnf install nodejs -y &>>$log_file
echo $?

echo copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?
echo add Application user
useradd expense &>>$log_file
echo $?
echo cleanup content
rm -rf /app
echo $?
mkdir /app
cd /app
echo download app content

download_and_extract
echo $?

echo download dependency=e
npm install &>>$log_file
echo $?
echo restart servoce
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
echo $?
echo download mysql
dnf install mysql -y &>>$log_file
echo $?
echo load schema
mysql -h 172.31.95.105 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
echo $?


