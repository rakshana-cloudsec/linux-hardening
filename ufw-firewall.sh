#!/bin/bash

# Script to configure and enable UFW firewall

echo "Checking if UFW is installed..."
if ! command -v ufw &> /dev/null; then
    echo "UFW is not installed. Installing UFW..."
    sudo apt update && sudo apt install ufw -y
else
    echo "UFW is already installed."
fi

echo "Setting default firewall policies..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "Allowing SSH (port 22) to prevent locking yourself out..."
sudo ufw allow ssh

# Example: Allow HTTP and HTTPS if this is a web server
# sudo ufw allow http
# sudo ufw allow https

echo "Enabling UFW..."
sudo ufw --force enable

echo "UFW status:"
sudo ufw status verbose

echo "Firewall has been successfully configured and enabled."
