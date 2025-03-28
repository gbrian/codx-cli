#!/bin/bash
curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh
sudo sh webmin-setup-repo.sh
sudo apt-get -y install --install-recommends webmin usermin
sudo /usr/share/webmin/changepass.pl /etc/webmin root 12345
echo "webadmin availble at http://localhost:10000 
webmin root password set to 12345
To change webmin root password run:
#: sudo /usr/share/webmin/changepass.pl /etc/webmin root <new_password>
"
