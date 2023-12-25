# https://gpt-engineer.readthedocs.io/en/latest/installation.html
source ~/.bashrc
BASH_RC=~/.bashrc

rm -rf gpt-engineer
git clone --single-branch --branch codx https://github.com/gbrian/gpt-engineer.git
cd gpt-engineer
if [ -z "$OPENAI_API_KEY" ]; then
    echo "OPENAI_API_KEY not found. Paste the openAI key here or edit $PWD/.env later."
    read -p "Key:" OPENAI_API_KEY
fi

if ! grep -q $OPENAI_API_KEY "$BASH_RC"; then
    echo "export OPENAI_API_KEY=$OPENAI_API_KEY" >> $BASH_RC
fi

if docker --version;then
  echo "****** INSTALLING DOCKER dgpt-engineer. Docker version"
  docker build -t gpt-engineer -f docker/Dockerfile .

  sudo cp dgpt-engineer.sh /usr/bin/gpt-engineer
  sudo chmod +x /usr/bin/gpt-engineer
else
  echo "****** DOCKER NOT FOUND. INSTALLING LOCALLY gpt-engineer. Docker version"
  sudo apt update
  sudo apt-get install -y python3-tk make

  bash $CODX_APPS/codx.sh python
  python3 -m pip install -e .

  GPT_ENGINEER_PATH=$PWD
  if ! grep -q "gpt-engineer" "$BASH_RC"; then
      echo "alias gpt-engineer='python3 ${GPT_ENGINEER_PATH}/gpt_engineer/cli/main.py'" >> $BASH_RC
  fi
fi
