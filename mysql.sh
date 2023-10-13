source commen.sh
echo disable mysql
dnf module disable mysql -y &>>$log_file
echo $?

echo copy mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
echo $?

echo download mysql server
dnf install mysql-community-server -y &>>$log_file
echo $?

echo start the service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
echo $?

echo setup root password
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
echo $?