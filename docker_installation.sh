#!/bin/bash

# This script will install Docker on Ubuntu

# Update and upgrade the system
echo "Updating the system..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Install dependencies required for Docker installation
echo "Installing required dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker repository
echo "Adding Docker repository..."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update the apt package index again after adding the Docker repository
echo "Updating apt package index..."
sudo apt-get update -y

# Install Docker
echo "Installing Docker..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start Docker and enable it to start on boot
echo "Starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Add the current user to the Docker group (so you can run Docker without sudo)
echo "Adding user to the Docker group..."
sudo usermod -aG docker $USER

# Inform the user that a reboot or new session might be required for group changes to take effect
echo "Please log out and log back in or reboot the system for the user group changes to take effect."
