#!/bin/bash
JAVA_JDK21_URL=https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.7%2B6/OpenJDK21U-jdk_x64_linux_hotspot_21.0.7_6.tar.gz

# Download and extract JDK
curl -L $JAVA_JDK21_URL -o jdk21.tar.gz
sudo mkdir /opt/jdk21
sudo tar -xzf jdk21.tar.gz -C /opt/jdk21 --strip-components=1
rm jdk21.tar.gz

# Set JDK as the active version
sudo update-alternatives --install /usr/bin/java java /opt/jdk21/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk21/bin/javac 1
sudo update-alternatives --set java /opt/jdk21/bin/java
sudo update-alternatives --set javac /opt/jdk21/bin/javac

sudo apt install -y maven
