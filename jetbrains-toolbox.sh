set -x
VERSION=2.1.1.18388
curl -sL "https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-${VERSION}.tar.gz" > jetbrains-toolbox-${VERSION}.tar.gz
sudo tar -xzf jetbrains-toolbox-${VERSION}.tar.gz -C /opt

echo "Execute jetbrains-toolbox"
