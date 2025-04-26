#!/bin/bash
sudo apt update
sudo apt install software-properties-common lsb-release apt-transport-https ca-certificates -y
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg 
sudo sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
sudo apt update
sudo apt install -y php8.3
