#!/bin/bash
COMMAND=$1
CODX_APPS=${CODX_APPS:-~/codx-cli}

echo "codx running command $COMMAND"
if [ "$COMMAND" = "--update" ]; then
  cd $CODX_APPS
  git config --global --add safe.directory $CODX_APPS
  sudo git pull
  exit
fi
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

rm -rf $CODX_APPS
sudo git clone https://github.com/gbrian/codx-cli.git $CODX_APPS
sudo chmod +x $CODX_APPS/codx.sh

BASHRC=~/.bashrc
echo "export CODX_APPS=${CODX_APPS}" >> $BASHRC
sudo cp $CODX_APPS/codx.sh /usr/bin/codx
