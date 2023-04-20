# coder/code-server
curl -sL https://github.com/coder/code-server/releases/download/v4.11.0/code-server_4.11.0_amd64.deb > code-server.deb

sudo dpkg -i $PWD/code-server.deb

# restart coder
ps aux | grep "code-server --bind" | for id in `awk {'print$2'}`;do kill &id ;done
