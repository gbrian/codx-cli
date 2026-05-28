[ -s "$NVM_DIR/nvm.sh" ] && exit

sudo apt install libatomic1

VERSION="0.40.3"
# https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${VERSION}/install.sh | bash

echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bashrc

source ~/.bashrc

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"
nvm install 25
npm install -g yarn

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Get the full paths
NVM_NODE_PATH=$(which node)
NVM_NPM_PATH=$(which npm)
NVM_NPX_PATH=$(which npx)

# Create symlinks
sudo ln -sf $NVM_NODE_PATH /usr/local/bin/node
sudo ln -sf $NVM_NPM_PATH /usr/local/bin/npm
sudo ln -sf $NVM_NPX_PATH /usr/local/bin/npx
