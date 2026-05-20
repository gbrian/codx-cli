#!/bin/bash

# Update and install the Azure Functions Core Tools
sudo npm install -g azure-functions-core-tools@4 --unsafe-perm true

# Verify installation
func --version
