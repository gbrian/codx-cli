#!/bin/bash
#Install gpg key
wget -O - https://repo.fortinet.com/repo/forticlient/7.4/ubuntu22/DEB-GPG-KEY | gpg --dearmor | sudo tee /usr/share/keyrings/repo.fortinet.com.gpg
#Create /etc/apt/sources.list.d/repo.fortinet.com.list with the following content
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/repo.fortinet.com.gpg] https://repo.fortinet.com/repo/forticlient/7.4/ubuntu22/ stable non-free" | sudo tee /etc/apt/sources.list.d/repo.fortinet.com.list
#Update package lists
sudo apt-get update
#Install FortiClient
sudo apt install forticlient
