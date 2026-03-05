#!/bin/bash

# Update package list and install dependencies
sudo apt update
sudo apt install -y curl ca-certificates gnupg

# Add the PostgreSQL signing key
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg

# Add the official PostgreSQL repository for Debian
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Update and install PostgreSQL (defaults to the latest version)
sudo apt update
sudo apt install -y postgresql postgresql-contrib

postgresql &
