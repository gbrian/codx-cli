#!/bin/bash
# https://www.tecmint.com/shellinabox-web-based-ssh-linux-terminal/

sudo apt install -y openssl shellinabox

# Configuring shellinabox
echo "SHELLINABOX_DAEMON_START=1" | sudo tee /etc/default/shellinabox
echo "SHELLINABOX_PORT=6175" | sudo tee -a /etc/default/shellinabox
echo "SHELLINABOX_ARGS=\"--no-beep\"" | sudo tee -a /etc/default/shellinabox
echo 'OPTS=\"-s /:SSH:192.168.0.140 --localhost-only\"' | sudo tee -a /etc/default/shellinabox

# Restart and check shellinabox status
sudo systemctl restart shellinabox
sudo systemctl status shellinabox
