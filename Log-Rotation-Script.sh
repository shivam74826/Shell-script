#!/bin/bash

# Set variables
LOG_DIR="/var/log/myapp"
LOG_EXTENSION=".log"
MAX_LOG_SIZE=10000000  # 10MB
RETENTION_DAYS=30

# Find and compress large logs
find $LOG_DIR -name "*$LOG_EXTENSION" -size +${MAX_LOG_SIZE}c -exec gzip {} \;

# Delete logs older than RETENTION_DAYS
find $LOG_DIR -name "*$LOG_EXTENSION.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

echo "Log rotation completed."
