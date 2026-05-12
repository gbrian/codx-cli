#!/bin/bash

# 1. Install Python 3 and Pip
sudo apt-get update && sudo apt-get install -y python3 python3-pip

# 2. Install the replacement tool via pip
sudo pip3 install docker-systemctl-replacement --break-system-packages

# 3. Locate the installed script (try 'systemctl3' then 'systemctl')
# pip often installs it as 'systemctl3' to avoid conflicts
SOURCE_PATH=$(which systemctl3 || which systemctl)

if [ -z "$SOURCE_PATH" ]; then
    echo "Error: Could not find the installed script. Checking common paths..."
    # Fallback search if 'which' fails
    SOURCE_PATH=$(ls /usr/local/bin/systemctl* /usr/bin/systemctl* 2>/dev/null | grep -v "/usr/bin/systemctl$" | head -n 1)
fi

if [ -n "$SOURCE_PATH" ]; then
    echo "Found script at: $SOURCE_PATH"
    # Create the symlink to the standard systemctl location
    sudo ln -sf "$SOURCE_PATH" /usr/bin/systemctl
    echo "Success: /usr/bin/systemctl is now linked to $SOURCE_PATH"
else
    echo "Error: Installation failed. Script not found in /usr/local/bin or /usr/bin."
    exit 1
fi

# 4. Final verification
/usr/bin/systemctl --version
