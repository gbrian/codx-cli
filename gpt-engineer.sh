# https://gpt-engineer.readthedocs.io/en/latest/installation.html
source ~/.bashrc
BASH_RC=~/.bashrc

rm -rf gpt-engineer
git clone --single-branch --branch ${GPT_ENGINEER_BRANCH:-codx} https://github.com/gbrian/gpt-engineer.git
cd gpt-engineer

if [ -z "$OPENAI_API_KEY" ]; then
    echo "AI_API_KEY not found. Paste the openAI key here or edit $PWD/.env later."
    read -p "Key:" OPENAI_API_KEY
fi

if ! grep -q $OPENAI_API_KEY "$BASH_RC"; then
    echo "export OPENAI_API_KEY=$OPENAI_API_KEY" >> $BASH_RC
fi

echo "****** INSTALLING gpt-engineer *********"
make buid-docker
chmod +x dgpt-engineer.sh
sudo ln -s $PWD/dgpt-engineer.sh /usr/bin/gpt-engineer
