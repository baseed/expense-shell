source commen.sh

component=frontend

echo installing nginx
dnf install nginx -y >>$log_file

echo placing Expense config file
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file

echo removing old nginx content
rm -rf /usr/share/nginx/html/* >>$log_file

cd /usr/share/nginx/html

download_and_extract

echo start the nginx service
systemctl enable nginx >>$log_file

systemctl restart nginx >>$log_file