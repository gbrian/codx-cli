#!/bin/bash
COMMAND=$1
CODX_APPS=~/codx-cli
mkdir -p $CODX_APPS

echo "Executing codx $COMMAND"
if [ "$COMMAND" == '--version' ] || [ "$COMMAND" == '-v' ]; then
  echo "codx ver 0.1"
  exit
fi
if [ $COMMAND ]; then 
  (cd $CODX_APPS && bash ./${COMMAND}.sh)
  exit
fi

# Register codx alias
sudo apt update
sudo apt install -y git

sudo rm -rf /etc/codx-cli
sudo git clone https://github.com/gbrian/codx-cli.git $CODX_APPS
sudo chmod +x $CODX_APPS/codx.sh

BASHRC=~/.bashrc
echo "export CODX_APPS=${CODX_APPS}" >> $BASHRC
echo "alias codx='${CODX_APPS}/codx.sh'" >> $BASHRC
