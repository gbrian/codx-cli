#!/bin/bash
idea_source=https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-2.5.2.35332.tar.gz

sudo apt install libfuse2

mkdir -p ~/opt/idea

echo "Preparing IntelliJ IDEA ..."
echo "Downloading ${idea_source} ..."
curl -fsSL $idea_source -o ~/opt/idea/installer.tgz
tar --strip-components=1 -xzf ~/opt/idea/installer.tgz -C ~/opt/idea
rm ~/opt/idea/installer.tgz

ln -s -f ~/.Idea ~/opt/idea
