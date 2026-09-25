#!/bin/bash

# Exit immediately if a command fails, or if an uninitialized variable is used
set -euo pipefail

DOCKER_COMPOSE_RELEASE_VER="2.35.1"
INSTALL_NEEDED=false

# 1. Independent Dependency Checks
if ! command -v docker &> /dev/null; then
    echo "🐳 Docker CLI is missing."
    INSTALL_NEEDED=true
else
    echo "✅ Docker CLI is already installed: $(docker --version)"
fi

# Check both the modern compose plugin and the standalone fallback binary
if ! docker compose version &> /dev/null && ! command -v docker-compose &> /dev/null; then
    echo "🐙 Docker Compose is missing."
    INSTALL_NEEDED=true
else
    echo "✅ Docker Compose is already available."
fi

# Exit early only if BOTH components are fully functional
if [ "$INSTALL_NEEDED" = false ]; then
    echo "🎉 Both Docker and Docker Compose are already installed. Nothing to do!"
    exit 0
fi

###
### https://docs.docker.com/engine/install/debian/#install-using-the-repository
###

# Clean old packages
echo "Removing conflicting old packages..."
sudo apt-get remove -y docker.io docker-doc docker-compose podman-docker containerd runc || true

# Add Docker's official GPG key:
echo "Setting up repository keys..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources using the official modern deb822 .sources style
echo "Adding Docker repository source..."
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt-get update

### Install docker components
echo "Installing Docker packages..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## docker-compose (Standalone binary fallback)
echo "Installing standalone Docker Compose binary..."
sudo curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_RELEASE_VER}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Create docker group safely if it doesn't exist
if ! getent group docker > /dev/null; then
  echo "Creating docker system group..."
  sudo groupadd docker
fi

# Add user to docker group
echo "Adding current user ($USER) to docker group..."
sudo usermod -aG docker "$USER"

# Reload the current shell's groups to apply permission updates instantly
echo "Refreshing group assignments and verifying connection..."
exec sg docker -c "docker version && docker compose version"
