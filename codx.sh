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
chmod +x codx-cli/codx.sh

echo "alias codx='bash /root/codx-cli/codx.sh'" >> ~/.bashrc
