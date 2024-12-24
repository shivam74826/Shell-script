#!/bin/bash

# Set threshold
THRESHOLD=90

# Get current disk usage percentage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# Check if disk usage exceeds threshold
if [ $DISK_USAGE -gt $THRESHOLD ]; then
    echo "Disk space is running low. Usage: $DISK_USAGE%" | mail -s "Disk Space Alert" user@example.com
fi
