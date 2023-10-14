
source commen.sh
component=backend

echo install nodejs
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file
dnf install nodejs -y &>>$log_file
if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi

echo copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file
if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi

echo add Application user
useradd expense &>>$log_file
if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi

echo cleanup content
rm -rf /app

if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi

    mkdir /app
cd /app
echo download app content

download_and_extract
if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi

echo download dependency=e
npm install &>>$log_file
if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi

echo restart servoce
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file
if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi

echo download mysql
dnf install mysql -y &>>$log_file
if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi

echo load schema
mysql -h 172.31.95.105 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file
if [ $?=0 ] then
  echo SUCSEES
  else
    echo FAIED
    fi


