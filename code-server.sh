VERSION=${1:-4.16.1}
curl -fOL https://github.com/coder/code-server/releases/download/v$VERSION/code-server_${VERSION}_amd64.deb
sudo dpkg -i code-server_${VERSION}_amd64.deb

code-server --bind-addr=0.0.0.0:9080 --auth=none
