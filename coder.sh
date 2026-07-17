#!/bin/bash

# Exit early if code-server is already installed
if command -v code-server &> /dev/null; then
  echo "code-server is already installed. Exiting script."
  exit 0
fi

curl -fsSL https://code-server.dev/install.sh | sh

[ "${1:-}" != "--no-run" ] && exit

export CODER_HTTP_ADDRESS=0.0.0.0:${PORT:-9080}

# Ensure the config directory exists before modifying the file
mkdir -p ~/.config/code-server
touch ~/.config/code-server/config.yaml

sed -i "s/127.0.0.1:8080/0.0.0.0:${PORT:-9080}/" ~/.config/code-server/config.yaml 
sed -i "s/auth: password/auth: none/" ~/.config/code-server/config.yaml 
code-server &
