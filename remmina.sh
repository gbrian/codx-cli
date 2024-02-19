echo 'deb http://deb.debian.org/debian bookworm-backports main' | sudo tee --append /etc/apt/sources.list.d/stretch-backports.list >> /dev/null
#echo 'deb http://ftp.debian.org/debian stretch-backports main' | sudo tee --append /etc/apt/sources.list.d/stretch-backports.list >> /dev/null
sudo apt update
sudo apt install -y -t bookworm-backports remmina remmina-plugin-rdp remmina-plugin-secret remmina-plugin-spice
