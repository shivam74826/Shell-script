#!/bin/bash



# Set directories
SOURCE_DIR="/home/user/documents"
BACKUP_DIR="/home/user/backups"
DATE=$(date +%Y-%m-%d-%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

# Create backup

echo "Starting backup of $SOURCE_DIR" to $BACKUP_DIR"
tar -czf $BACKUP_FILE $SOURCE_DIR

# Check if the backup was successful
if [$? -eq 0]; then
   echo "backup successful!"
else
  echo "Backup failed"

# Remove backups older then 30 Days
find $BACKUP_DIR -type f -name "bakcup_*.tar.gz" -mtime +30 -exec rm {} \;

echo "Oder backups deleted."
