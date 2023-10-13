log_file=/tmp/expense.log
echo installing nginx
dnf install nginx -y >>$log_file

echo placing Expense config file
cp expense.conf /etc/nginx/default.d/expense.conf >>$log_file

echo removing old nginx content
rm -rf /usr/share/nginx/html/* >>$log_file

echo Downloaded Frontent code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>$log_file

cd /usr/share/nginx/html

echo Extracting Frontend
unzip /tmp/frontend.zip >>$log_file

echo start the nginx service
systemctl enable nginx >>$log_file

systemctl restart nginx >>$log_file