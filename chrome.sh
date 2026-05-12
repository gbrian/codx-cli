#!/bin/bash
# Download the latest stable Google Chrome package
wget -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install the package and resolve any missing dependencies
sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb

# Create the 'chrome' alias if it doesn't exist
sudo ln -sf /usr/bin/google-chrome /usr/bin/chrome

# Clean up
rm /tmp/google-chrome-stable_current_amd64.deb
