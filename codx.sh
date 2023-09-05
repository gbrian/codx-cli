#!/bin/bash
COMMAND=$1
CODX_APPS=$(dirname -- "$0")
if [ $COMMAND ]; then 
  bash $CODX_APPS/${COMMAND}.sh
  exit
fi

# Register codx alias
sudo apt update
sudo apt install -y git

cd $CODX_APPS
rm -rf codx-cli
git clone https://github.com/gbrian/codx-cli.git
chmod +x codx-cli/codx.sh

echo "alias codx='bash ${CODX_APPS}/codx-cli/codx.sh'" >> ~/.bashrc
