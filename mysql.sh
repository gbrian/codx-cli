sudo apt update
sudo apt install gnupg
wget https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb
sudo dpkg -i mysql-apt-config*
sudo apt update
sudo apt install -y mysql-server

