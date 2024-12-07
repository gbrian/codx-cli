#!/bin/bash

if [ ! -x "/usr/bin/openfortivpn" ]; then
  # You must be sudo
  wget -O - https://repo.fortinet.com/repo/7.0/ubuntu/DEB-GPG-KEY | apt-key add - \
  deb [arch=amd64] https://repo.fortinet.com/repo/7.0/ubuntu xenial multiverse \
  apt-get update
  apt install forticlient
fi

SVPNCOOKIE=${SVPNCOOKIE:-1}
if [ -n "$SVPNCOOKIE" ]; then
  openfortivpn -c /etc/openfortivpn/my-config
        -v -v -v \
        --cookie=SVPNCOOKIE=${SVPNCOOKIE}
fi
    
