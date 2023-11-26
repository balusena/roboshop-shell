echo -e "\e[33mConfiguring NodeJS Repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33mInstall NodeJS\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mRemoving Old App Content\e[0m"
rm -rf /app &>>/tmp/roboshop.log

echo -e "\e[33mSetup app directory\e[0m"
mkdir /app

echo -e "\e[33mDownload the application code to created app directory\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[33mDownload the dependencies\e[0m"
cd /app
npm install &>>/tmp/roboshop.log


echo -e "\e[33mSetup SystemD Cart Service\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[33mLoad and Restart the services\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log
