source commen.sh
echo disable mysql
dnf module disable mysql -y &>>  $log_file
stat_check

echo copy mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check

echo download mysql server
dnf install mysql-community-server -y &>>$log_file
stat_check

echo start the service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
stat_check

echo setup root password
mysql_root_password=$1
mysql_secure_installation --set-root-pass $mysql_root_password &>>$log_file
stat_check