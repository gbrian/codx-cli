wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-update
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-${VERSION:-6.0}
