echo -e "\e[33mInstall Redis Repos\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo -e "\e[33mEnable Redis 6 version\e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

echo -e "\e[33mInstall Redis\e[0m"
yum install redis -y &>>/tmp/roboshop.log

echo -e "\e[33mUpdate Redis Listen Address\e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log

echo -e "\e[33mEnable and Restart the Redis Service\e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log
