#!/bin/bash

# Check for available package updates
echo "Checking for updates..."
sudo apt-get update -y

# Install available updates
echo "Installing updates..."
sudo apt-get upgrade -y

# Install security updates
echo "Installing security updates..."
sudo apt-get dist-upgrade -y

# Clean up unnecessary packages
echo "Removing unnecessary packages..."
sudo apt-get autoremove -y

# Check if a reboot is required
if [ -f /var/run/reboot-required ]; then
    echo "Reboot required. Rebooting now..."
    sudo reboot
else
    echo "No reboot required."
fi
