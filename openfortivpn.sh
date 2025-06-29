#!/bin/bash

if [ ! -x "/usr/bin/openfortivpn" ]; then
  sudo apt-get update
  sudo apt install -y openfortivpn nano
  sudo mknod /dev/ppp c 108 0
fi

function create_config() {
    echo "host = 
port = 
username = 
password = 
set-dns = 1
pppd-use-peerdns = 0
trusted-cert ="  > .conf
  sudo mv .conf /etc/openfortivpn/openfortivpn.conf
  # Let user set de values
  sudo nano /etc/openfortivpn/openfortivpn.conf
}

if [ ! -f "/etc/openfortivpn/openfortivpn.conf" ]; then
  echo "Creating vpn config /etc/openfortivpn/openfortivpn.conf"
  create_config
fi

while true; do
  echo "SVPNCOOKIE: "
  read SVPNCOOKIE

  sudo openfortivpn -c /etc/openfortivpn/openfortivpn.conf \
      -v -v -v \
      --cookie=SVPNCOOKIE=${SVPNCOOKIE} &
done
