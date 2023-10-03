# https://www.inmotionhosting.com/support/edu/wordpress/install-wordpress-debian-10/
# SET UP DATABASE
sudo apt install -y mariadb-server mphp libapache2-mod-php php-mysql wget

DB="wordpress"
USER="dbuser"
PASS="dbuser1234"

mysql -uroot -prootpassword -e "CREATE DATABASE $DB CHARACTER SET utf8 COLLATE utf8_general_ci";
mysql -uroot -prootpassword -e "CREATE USER $USER@'127.0.0.1' IDENTIFIED BY '$PASS'";
mysql -uroot -prootpassword -e "GRANT SELECT, INSERT, UPDATE ON $DB.* TO '$USER'@'127.0.0.1'";

# APACHE
mkdir -p /var/www/html
cd /var/www/html
wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz 
mv wordpress/* ./
rm -f latest.tar.gz
rm index.html

cp wp-config-sample.php wp-config.php

