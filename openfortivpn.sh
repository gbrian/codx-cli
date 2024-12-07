#!/bin/bash

if [ ! -x "/usr/bin/openfortivpn" ]; then
  # You must be sudo
  wget -O - https://repo.fortinet.com/repo/7.0/ubuntu/DEB-GPG-KEY | apt-key add - \
  deb [arch=amd64] https://repo.fortinet.com/repo/7.0/ubuntu xenial multiverse \
  apt-get update
  apt install forticlient

  if [ ! -t "/etc/openfortivpn/openfortivpn.conf" ]; then
    echo "
    host = 
    port = 
    username = 
    password = 
    set-dns = 0
    pppd-use-peerdns = 0
    # X509 certificate sha256 sum, trust only this one!
    trusted-cert = 
    " > /etc/openfortivpn/openfortivpn.conf
  fi
fi

SVPNCOOKIE=${SVPNCOOKIE:-1}

if [ -n "$SVPNCOOKIE" ]; then
  openfortivpn -c /etc/openfortivpn/openfortivpn.conf
        -v -v -v \
        --cookie=SVPNCOOKIE=${SVPNCOOKIE}
else
  echo "SVPNCOOKIE not found"
  echo "Usage codx openfortivpn SVPNCOOKIE"
fi
    
