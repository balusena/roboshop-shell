echo -e "\e[33m Install maven this indeed takes care of java installation.\e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mRemoving Old App Content\e[0m"
rm -rf /app &>>/tmp/roboshop.log

echo -e "\e[33mSetup app directory\e[0m"
mkdir /app

echo -e "\e[33mDownload and Extract the application code to created app directory\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33mDownload Maven Dependencies\e[0m"
cd /app &>>/tmp/roboshop.log
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log

echo -e "\e[33mSetup SystemD Shipping Service\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[33mInstall MySQL-Client\e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[33mSetup MySQL Password\e[0m"
mysql -h mysql-dev.robobal.store -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[33mReload Enable and Restart the Shipping Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log