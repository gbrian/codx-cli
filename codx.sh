#!/bin/bash
COMMAND=$1
CODX_APPS=/etc/codx-cli

echo "Executing codx $COMMAND"
if [ $COMMAND == '--version' ] || [ $COMMAND == '-v' ]; then
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

cd /etc
source /etc/environment
sudo rm -rf codx-cli
sudo git clone https://github.com/gbrian/codx-cli.git
sudo chmod +x codx-cli/codx.sh

echo "export CODX_APPS=${CODX_APPS}" >> ~/.bashrc
echo "alias codx='${CODX_APPS}/codx.sh'" >> ~/.bashrc
