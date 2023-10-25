# Install latest version
curl -fsSL https://code-server.dev/install.sh | sh
# Register host name
echo "0.0.0.0:9080 code-server" >> /etc/hosts
# Run in background
code-server --bind-addr=0.0.0.0:9080 --auth=none &
