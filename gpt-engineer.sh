# https://gpt-engineer.readthedocs.io/en/latest/installation.html
sudo apt update
sudo apt-get install -y python3-tk make

codx python

rm -rf gpt-engineer
git clone --single-branch --branch codx https://github.com/gbrian/gpt-engineer.git
cd gpt-engineer
if [ -z "$OPENAI_API_KEY" ]; then
    echo "OPENAI_API_KEY not found. Paste the openAI key here or edit $PWD/.env later."
    read -p "Key:" OPENAI_API_KEY
fi
echo "OPENAI_API_KEY=$OPENAI_API_KEY" > .env
python3 -m pip install -e .

GPT_ENGINEER_PATH=$PWD
echo "alias gpt-engineer='python3 ${GPT_ENGINEER_PATH}/gpt_engineer/cli/main.py'" >> ~/.bashrc
