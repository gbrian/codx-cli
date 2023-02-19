#!/bin/bash
COMMAND=$1
if [ $COMMAND ]; then 
  bash $CODX_APPS/${COMMAND}.sh
  exit
fi

# Register codx alias
sudo apt-update
sudo apt install -y git

git clone https://github.com/gbrian/codx-cli.git

sudo echo "" >> /etc/profile