#!/bin/bash
DOTNET_VERSION=${DOTNET_VERSION:-latest}
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --version ${DOTNET_VERSION}
sudo ln -s $HOME/.dotnet/dotnet /usr/bin/dotnet

# Nuget credential manager
curl -sL https://raw.githubusercontent.com/microsoft/artifacts-credprovider/refs/heads/master/helpers/installcredprovider.sh | bash -
