# https://gpt-engineer.readthedocs.io/en/latest/installation.html
source ~/.bashrc
BASH_RC=~/.bashrc

rm -rf gpt-engineer
git clone --single-branch --branch ${GPT_ENGINEER_BRANCH:-codx} https://github.com/gbrian/gpt-engineer.git
cd gpt-engineer
