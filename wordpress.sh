# https://www.inmotionhosting.com/support/edu/wordpress/install-wordpress-debian-10/
# SET UP DATABASE
sudo apt install -y mariadb-server mphp libapache2-mod-php php-mysql wget

DB="wordpress"
DB_USER="dbuser"
DB_PASS="dbuser1234"

mysql -uroot -prootpassword -e "CREATE DATABASE $DB CHARACTER SET utf8 COLLATE utf8_general_ci";
mysql -uroot -prootpassword -e "CREATE USER $DB_USER@'127.0.0.1' IDENTIFIED BY '$DB_PASS'";
mysql -uroot -prootpassword -e "GRANT SELECT, INSERT, UPDATE ON $DB.* TO '$DB_USER'@'127.0.0.1'";

# APACHE
mkdir -p /var/www/html
cd /var/www/html
wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz 
cp -r wordpress/* ./
rm -f latest.tar.gz
rm index.html

cp wp-config-sample.php wp-config.php

sudo sed -i "s/database_name_here/$DB/g" wp-config.php
sudo sed -i "s/username_here/$DB_USER/g" wp-config.php
sudo sed -i "s/password_here/$DB_PASS/g" wp-config.php

