#!/bin/bash
COMMAND=$1
shift
CODX_APPS=/usr/local/codx-cli

echo "codx running command $COMMAND"
if [ "$COMMAND" = "--update" ]; then
  cd $CODX_APPS
  sudo git config --global --add safe.directory $CODX_APPS
  sudo git pull
  exit
fi

if [ "$COMMAND" = "--list" ]; then
  basename --suffix=.sh -- ${CODX_APPS}/*.sh
  exit
fi

echo "Executing codx $COMMAND"
if [ "$COMMAND" == '--version' ] || [ "$COMMAND" == '-v' ]; then
  echo "codx ver 0.1"
  exit
fi
if [ $COMMAND ]; then 
  (cd $HOME && bash $CODX_APPS/${COMMAND}.sh $@)
  exit
fi

sudo apt update
sudo apt install -y git wget
sudo rm -rf $CODX_APPS
sudo git clone https://github.com/gbrian/codx-cli.git $CODX_APPS
sudo chmod +x $CODX_APPS/codx.sh
# Remove previous installation link
sudo rm /usr/local/bin/codx || true
sudo ln -s $CODX_APPS/codx.sh /usr/local/bin/codx
