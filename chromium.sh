# Update package list and install Chromium
sudo apt update
sudo apt install -y chromium

# Create the 'chrome' alias if you want it to launch Chromium
sudo ln -sf /usr/bin/chromium /usr/bin/chrome
