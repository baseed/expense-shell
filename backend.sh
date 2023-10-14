
source commen.sh
component=backend

echo install nodejs
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
dnf install nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAIED\e[0m"
    exit
    fi

echo copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAIED\e[0m"
    exit
    fi

echo add Application user
useradd expense &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAIED\e[0m"
    exit
    fi

echo cleanup content
rm -rf /app

if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAIED\e[0m"
    exit
    fi

mkdir /app
cd /app
echo download app content

download_and_extract

if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAIED\e[0m"
    exit
    fi

echo download dependence

npm install &>>$log_file

if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAIED\e[0m"
    exit
    fi

echo restart servoce
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAIED\e[0m"
    exit
    fi

echo download mysql
dnf install mysql -y &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAIED\e[0m"
    eit
    fi
echo load schema
mysql -h 172.31.95.105 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCSEES\e[0m"
  else
    echo -e "\e[31mFAILED\e[0m"
    exit
    fi

