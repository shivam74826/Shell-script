#!/bin/bash

# Set directories to clean up
CACHE_DIR="/var/cache"
TMP_DIR="/tmp"
LOG_DIR="/var/log"

# Clean up apt cache (for Debian/Ubuntu)
echo "Cleaning apt cache..."
sudo apt-get clean

# Clean up system temp files
echo "Cleaning temporary files..."
sudo rm -rf $TMP_DIR/*

# Clean up log files older than 7 days
echo "Cleaning log files..."
find $LOG_DIR -name "*.log" -type f -mtime +7 -exec rm {} \;

# Clean up unused Docker images, containers, and volumes (if using Docker)
echo "Cleaning up Docker..."
docker system prune -f

# Clean up cache
echo "Cleaning cache..."
sudo rm -rf $CACHE_DIR/*

echo "Disk cleanup completed."
