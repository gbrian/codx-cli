#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status

# 1. Update package lists and install utilities + matching linux-headers
echo "Updating package lists and installing dependencies..."
sudo apt-get update
sudo apt-get install jq wget curl linux-headers-$(uname -r) -y

# 2. Automatically grab the latest release version tag from GitHub API
echo "Fetching latest Sysbox release tag..."
LATEST_TAG=$(curl -s https://api.github.com/repos/nestybox/sysbox/tags | jq -r '.[0].name')
VERSION_NUM=${LATEST_TAG#v} # Strips the 'v' from the version tag

# 3. Detect your system's architecture (amd64 or arm64)
ARCH=$(dpkg --print-architecture)

# 4. Construct download URL and fetch the Debian package to /tmp (avoids _apt sandbox errors)
URL="https://github.com/nestybox/sysbox/releases/download/${LATEST_TAG}/sysbox-ce_${VERSION_NUM}.linux_amd64.deb"
DEB_PATH="/tmp/sysbox-ce_${VERSION_NUM}-0.linux_${ARCH}.deb"

echo "Downloading Sysbox ${LATEST_TAG} for ${ARCH}..."
wget -O "$DEB_PATH" "$URL"

# Ensure the _apt user can read the file for a clean install
chmod 644 "$DEB_PATH"

# 5. Deploy the downloaded package using apt
echo "Installing Sysbox..."
sudo apt-get install --reinstall "$DEB_PATH" -y

# 6. Clean up the installer file
rm -f "$DEB_PATH"
echo "Sysbox installation complete!"
