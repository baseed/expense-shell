echo installing nginx
dnf install nginx -y >>/tmp/expense.log

echo placing Expense config file
cp expense.conf /etc/nginx/default.d/expense.conf >>/tmp/expense.log

echo removing old nginx content
rm -rf /usr/share/nginx/html/* >>/tmp/expense.log

echo Downloaded Frontent code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>/tmp/expense.log

cd /usr/share/nginx/html

echo Extracting Frontend
unzip /tmp/frontend.zip >>/tmp/expense.log

echo start the nginx service
systemctl enable nginx >>/tmp/expense.log

systemctl restart nginx >>/tmp/expense.log