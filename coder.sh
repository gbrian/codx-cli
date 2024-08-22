# https://github.com/coder/code-server/releases
export VERSION=$(curl --silent "https://api.github.com/repos/coder/code-server/releases/latest" | jq -r .tag_name)
export VERSION_NUMBER=${VERSION:1}
export CODER_HTTP_ADDRESS=0.0.0.0:${PORT:-9080}

curl -fOL https://github.com/coder/code-server/releases/download/$VERSION/code-server_${VERSION_NUMBER}_amd64.deb
sudo dpkg -i code-server_${VERSION_NUMBER}_amd64.deb
sed -i "s/127.0.0.1:8080/0.0.0.0:9080/" /root/.config/code-server/config.yaml 
sed -i "s/auth: password/auth: none/" /root/.config/code-server/config.yaml 

code-server &
