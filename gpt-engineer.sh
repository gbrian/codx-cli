# https://gpt-engineer.readthedocs.io/en/latest/installation.html
sudo apt update
sudo apt-get install -y python3-tk make

codx python
source ~/.bashrc

rm -rf gpt-engineer
git clone --single-branch --branch codx https://github.com/gbrian/gpt-engineer.git
cd gpt-engineer
if [ -z "$OPENAI_API_KEY" ]; then
    echo "OPENAI_API_KEY not found. Paste the openAI key here or edit $PWD/.env later."
    read -p "Key:" OPENAI_API_KEY
fi
python3 -m pip install -e .

GPT_ENGINEER_PATH=$PWD
BASH_RC=~/.bashrc
if ! grep -q $OPENAI_API_KEY "$BASH_RC"; then
    echo "export OPENAI_API_KEY=$OPENAI_API_KEY" >> $BASH_RC
fi
if ! grep -q "gpt-engineer" "$BASH_RC"; then
    echo "alias gpt-engineer='python3 ${GPT_ENGINEER_PATH}/gpt_engineer/cli/main.py'" >> $BASH_RC
fi
