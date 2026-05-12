#!/bin/bash

# 1. Ensure Python and Curl are installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 not found. Installing..."
    sudo apt-get update && sudo apt-get install -y python3 curl
fi

# 2. Download the systemctl replacement script
# We download it to a temporary location first to avoid permission issues during the curl
echo "Downloading systemctl replacement..."
curl -L https://githubusercontent.com -o /tmp/systemctl

# 3. Move to /usr/bin/ and set permissions
echo "Installing to /usr/bin/systemctl..."
sudo mv /tmp/systemctl /usr/bin/systemctl
sudo chmod +x /usr/bin/systemctl

# 4. Create the systemd runtime directory
# Required for many deployment tools to "see" the systemd environment
sudo mkdir -p /run/systemd/system

echo "Installation complete. You can now use 'sudo systemctl start <service>'."
