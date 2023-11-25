echo -e "\e[33mInstall Python3\e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mRemoving Old App Content\e[0m"
rm -rf /app &>>/tmp/roboshop.log

echo -e "\e[33mSetup app directory\e[0m"
mkdir /app

echo -e "\e[33mDownload and Extract the application code to created app directory\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/payment.zip &>>/tmp/roboshop.log

echo -e "\e[33mInstall the Application dependencies\e[0m"
cd /app
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[33mSetup SystemD Payment Service\e[0m"
cp /home/centos/roboshop-shell/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[33mReLoad Enable and Restart the services\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log