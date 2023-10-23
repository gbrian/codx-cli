# https://www.mongodb.com/docs/v7.0/tutorial/install-mongodb-on-debian/
# Import the public key used by the package management system
# From a terminal, install gnupg and curl if they are not already available:
sudo apt-get install gnupg curl

# To import the MongoDB public GPG key from 
# https://pgp.mongodb.com/server-7.0.asc
# , run the following command:

curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor


# Create a /etc/apt/sources.list.d/mongodb-org-7.0.list file for MongoDB.
# Create the list file using the command appropriate for your version of Debian:


# Debian 11 "Bullseye"
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] http://repo.mongodb.org/apt/debian bullseye/mongodb-org/7.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list


# Reload local package database
# Issue the following command to reload the local package database:

sudo apt-get update


# Install the MongoDB packages
# You can install either the latest stable version of MongoDB or a specific version of MongoDB.


# Install the latest version of MongoDB

# Install a specific release of MongoDB
# To install the latest stable version, issue the following

sudo apt-get install -y mongodb-org
