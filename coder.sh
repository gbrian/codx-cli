
curl -fsSL https://code-server.dev/install.sh | sh

[ "$1" != "--no-run" ] && exit

export CODER_HTTP_ADDRESS=0.0.0.0:${PORT:-9080}
sed -i "s/127.0.0.1:8080/0.0.0.0:${PORT:-9080}/" ~/.config/code-server/config.yaml 
sed -i "s/auth: password/auth: none/" ~/.config/code-server/config.yaml 
code-server &
