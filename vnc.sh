#!/bin/bash

# Ensure the system is up to date
sudo apt-get update -y

# Install XFCE4 desktop environment and TightVNC package
sudo apt-get install -y xfce4 xfce4-goodies tightvncserver dbus-x11

# Initial setting up of password for VNC server
# Please change the "YourPassword" to your preferred password.
mkdir ~/.vnc
echo YourPassword | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Stop the VNC session:
vncserver -kill :1

# Backup previous xstartup file
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak

# Starter script for VNC
cat << EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF

# Allow execution of starter script
chmod +x ~/.vnc/xstartup

# Install NoVNC html package
sudo apt-get install -y novnc websockify

# Make Sure that there are no processes running on required ports
fuser -k 6080/tcp
fuser -k 5901/tcp

# Start VNC server & Websockify
FRAMEBUFFER_WIDTH=1280 
FRAMEBUFFER_HEIGHT=720
export GEOMETRY="${FRAMEBUFFER_WIDTH}x${FRAMEBUFFER_HEIGHT}"
vncserver :1 -geometry $GEOMETRY -depth 24 
websockify --web=/usr/share/novnc/ 6080 localhost:5901
