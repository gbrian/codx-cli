# https://gpt-engineer.readthedocs.io/en/latest/installation.html
sudo apt update
sudo apt-get install -y python3-tk make

git clone https://github.com/AntonOsika/gpt-engineer.git
cd gpt-engineer
pip install -e .

GPT_ENGINEER_PATH=$PWD
echo "alias gpt-engineer='python3 ${GPT_ENGINEER_PATH}/gpt_engineer/cli/main.py'" >> ~/.bashrc
