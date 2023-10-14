log_file=/tmp/expense.log

download_and_extract(){
  echo Downloaded component code
  curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip &>>$log_file

stat_check

  echo Extracting $component
  unzip /tmp/$component.zip &>>$log_file
 stat_check
}
stat_check(){
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCSEES\e[0m"
    else
      echo -e "\e[31mFAIED\e[0m"
      exit 1
      fi
}