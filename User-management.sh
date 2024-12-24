#!/bin/bash

# Get user Information

read -p "Enter the username to create: " USERNAME
read -p "Enter password for $USERNAME: " PASSWORD
echo
read -p "Enter full name for $USERNAME: " FULLNAME


# Check if user exists
if id "$USERNAME" &>/dev/null; then
  echo "User $USERNAME" already exists!"
  exit 1
  
fi
# Create the user and set password
useradd -m -c "$FULLNAME" "$USERNAME"
echo "$USERNAME:$PASSWORD" | chpasswd

# Set up directories
mkdir -p /home/$USERNAME/work /home/$USERNAME/projects
chown -R $USERNAME:$USERNAME /home/$USERNAME

# Display user details
echo "User $USERNAME created successfully!"
echo "Home directory: /home/$USERNAME"
echo "Full name: $FULLNAME"
