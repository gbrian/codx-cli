VERSION=${1:-4.17.1}
curl -fOL https://github.com/coder/code-server/releases/download/v$VERSION/code-server_${VERSION}_amd64.deb
sudo dpkg -i code-server_${VERSION}_amd64.deb
echo "127.0.0.1:9080 code-server.app" >> /etc/hosts
code-server --bind-addr=0.0.0.0:9080 --auth=none &
