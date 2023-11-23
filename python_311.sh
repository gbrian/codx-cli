#!/bin/bash
# https://tecadmin.net/how-to-install-python-3-11-on-debian/

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Install required packages for compilation
sudo apt install -y wget build-essential libncursesw5-dev libssl-dev \
     libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev  

# Download Python 3.11 source code
wget https://www.python.org/ftp/python/3.11.3/Python-3.11.3.tgz

# Extract the archive
tar xzf Python-3.11.3.tgz

# Change to the extracted directory
cd Python-3.11.3

# Prepare the Python source code for compilation
./configure --enable-optimizations

# Compile and install Python
make altinstall

# Check Python version
python3.11 -V

# Check pip version
pip3.11 -V

echo "Python 3.11 has been successfully installed on your Debian system."
