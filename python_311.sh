#!/bin/bash

# Add SID repository to sources.list
echo "deb http://deb.debian.org/debian/ sid main" | sudo tee -a /etc/apt/sources.list

# Update the package list
sudo apt update

# Install Python 3.11 from SID repository
sudo apt install -t sid -y python3.11  python3.11-venv

# Verify the installation
VERSION=$(python3.11 -V)

# Optionally, remove SID repository to avoid potential instability
sudo sed -i '/deb http:\/\/deb.debian.org\/debian\/ sid main/d' /etc/apt/sources.list
sudo apt update

echo "Python 3.11 has been successfully installed on your Debian Bullseye system. $VERSION"
