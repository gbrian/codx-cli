#!/bin/bash

# Variables
PYCHARM_URL="https://download.jetbrains.com/python/pycharm-community-2024.3.1.1.tar.gz"
PYCHARM_TAR="pycharm-community-2024.3.1.1.tar.gz"
INSTALL_DIR="/opt"
LINK_DIR="/usr/local/bin"
LINK_NAME="pycharm"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for necessary commands
if ! command_exists curl && ! command_exists wget; then
    echo "Error: curl or wget is required to download files. Please install one of them and try again."
    exit 1
fi

# Check if tar is installed
if ! command_exists tar; then
    echo "Error: tar is required to extract files. Please install tar and try again."
    exit 1
fi

# Download PyCharm
echo "Downloading PyCharm..."
if command_exists curl; then
    curl -L -o "$PYCHARM_TAR" "$PYCHARM_URL"
elif command_exists wget; then
    wget -O "$PYCHARM_TAR" "$PYCHARM_URL"
fi

# Verify the integrity of the downloaded archive (this part assumes you have the SHA checksum)
# SHA_CHECKSUM="your-sha256-checksum-here"
# echo "${SHA_CHECKSUM}  ${PYCHARM_TAR}" | sha256sum -c -

# Extract the downloaded archive to the /opt directory
echo "Extracting PyCharm to $INSTALL_DIR..."
sudo tar xzf "$PYCHARM_TAR" -C "$INSTALL_DIR"

# Find the extracted directory name
EXTRACTED_DIR=$(tar -tf "$PYCHARM_TAR" | head -1 | cut -f1 -d"/")

# Create a symbolic link to the pycharm.sh script
echo "Creating symbolic link..."
sudo ln -sf "$INSTALL_DIR/$EXTRACTED_DIR/bin/pycharm.sh" "$LINK_DIR/$LINK_NAME"

# Clean up the downloaded archive
echo "Cleaning up..."
rm "$PYCHARM_TAR"

# Success message
echo "PyCharm installed successfully. You can run it by typing 'pycharm' in the terminal."
