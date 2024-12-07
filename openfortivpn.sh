#!/bin/bash

if [ ! -x "/usr/bin/openfortivpn" ]; then
  # You must be sudo
  apt-get update
  apt install openfortivpn

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
    
