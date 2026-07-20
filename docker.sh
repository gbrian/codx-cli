#!/bin/bash

# Exit immediately if a command fails, or if an uninitialized variable is used
set -euo pipefail

# Check if Docker CLI is installed
if command -v docker &> /dev/null; then
    echo " Docker CLI is already installed: $(docker --version). Exiting."
    exit 0
fi

DOCKER_COMPOSE_RELEASE_VER="2.35.1"

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

# Add the repository to Apt sources:
echo "Adding Docker repository source..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

### Install docker
echo "Installing Docker components..."
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

# CRITICAL FIX: Reload the current shell's groups to apply permission updates instantly
echo "Refreshing group assignments and verifying connection..."
exec sg docker -c "docker version"
