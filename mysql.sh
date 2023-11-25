echo -e "\e[33mDisable MySQL Default 8 version.\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log

echo -e "\e[33mCopy MySQL Repo file\e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstall MySQL Community Server\e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33mEnable and Restart the MySQL Service\e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log

echo -e "\e[33mSetup MySQL Password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log