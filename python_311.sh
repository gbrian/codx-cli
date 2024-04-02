#!/bin/bash

# Update the package list
sudo apt update

# Install Python 3.11 from SID repository
sudo apt install -y python3 python3-pip python3-venv

# Verify the installation
VERSION=$(python3 -V)

echo "Python 3.11 has been successfully installed on your Debian Bullseye system. $VERSION"
