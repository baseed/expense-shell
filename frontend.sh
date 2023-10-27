source commen.sh

component=frontend

echo installing nginx
dnf install nginx -y &>>$log_file
stat_check
echo placing Expense config file
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
stat_check

echo removing old nginx content
rm -rf /usr/share/nginx/html/* &>>$log_file
stat_check

cd /usr/share/nginx/html

download_and_extract
stat_check

echo enable the nginx service
systemctl enable nginx &>>$log_file
stat_check

echo Restart the nginx service
systemctl restart nginx &>>$log_file
stat_check