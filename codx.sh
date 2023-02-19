#!/bin/bash
COMMAND=$1
if [ $COMMAND ]; then 
  bash $CODX_APPS/${COMMAND}.sh
  exit
fi

# Register codx alias
sudo apt-update
sudo apt install -y git

rm -rf codx-cli
git clone https://github.com/gbrian/codx-cli.git

sudo echo "CODX_APPS=${PWD}/codx-cli" >> /etc/environment
sudo echo "alias codx='${PWD}/codx-cli/codx.sh'" >> /etc/profile
