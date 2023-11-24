echo -e "\e[32mCopy MongoDB Repo\e[0m"
cp mongodb.rep /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[32mInstalling MongoDB Server\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[32mStart MongoDB Service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log