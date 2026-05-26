#!/bin/bash

# FIX: Couldn't find a valid ICU package installed on the system
sudo apt i -y libicu-dev

# 1. Determine version: Use $1 if provided, otherwise default to latest
DOTNET_VERSION=${1:-latest}

echo "Installing .NET version: $DOTNET_VERSION..."

# 2. Download and run the official install script
curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh
chmod +x ./dotnet-install.sh

# Use --channel as it handles both 'latest' and specific versions (8.0, 9.0) better
./dotnet-install.sh --channel ${DOTNET_VERSION}

# 3. Create symlink (using -f to overwrite if it already exists)
sudo ln -sf $HOME/.dotnet/dotnet /usr/bin/dotnet

# 4. Nuget credential manager
echo "Installing NuGet Credential Provider..."
curl -sL https://raw.githubusercontent.com/microsoft/artifacts-credprovider/refs/heads/master/helpers/installcredprovider.sh | bash -

# 5. Azure CLI
echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# 6. Cleanup
rm dotnet-install.sh

echo "Done! Current dotnet version:"
dotnet --version
