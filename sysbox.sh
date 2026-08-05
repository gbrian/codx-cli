# 1. Install necessary utility tools
sudo apt-get update
sudo apt-get install jq wget curl -y

# 2. Automatically grab the latest release version tag from GitHub API
LATEST_TAG=$(curl -s https://api.github.com/repos/nestybox/sysbox/tags | jq -r '.[0].name')
VERSION_NUM=${LATEST_TAG#v} # Strips the 'v' from the version tag

# 3. Detect your system's architecture (amd64 or arm64)
ARCH=$(dpkg --print-architecture)

# 4. Construct download URL and fetch the Debian package
# Note: GitHub releases host assets using a structured URL pattern
URL="https://github.com{LATEST_TAG}/sysbox-ce_${VERSION_NUM}-0.linux_${ARCH}.deb"
echo "Downloading Sysbox ${LATEST_TAG} for ${ARCH}..."
wget "$URL"

# 5. Deploy the downloaded package using apt
sudo apt-get install ./sysbox-ce_${VERSION_NUM}-0.linux_${ARCH}.deb -y
