#!/bin/bash

# Set thresholds
CPU_THRESHOLD=85
MEMORY_THRESHOLD=80
DISK_THRESHOLD=90

# Get current CPU usage
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0.9]*\)%*\ .id*/\1" | awk '{print 100 - $1}')
if [$(echo "$CPU_LOAD > $CPU_THRESOLD" | bc) -eq 1 ]; then
   echo "WARRING: CPU load is hight at $CPU_LOAD%"

# Get current memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if [ $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc) -eq 1 ]; then
    echo "WARNING: Memory usage is high at $MEMORY_USAGE%"
fi

# Get current disk usage
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
    echo "WARNING: Disk usage is high at $DISK_USAGE%"
fi

# Check for high load (load average over 1, 5, 15 minutes)
LOAD_AVG=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | sed 's/ //g')
if [ $(echo "$LOAD_AVG > 5" | bc) -eq 1 ]; then
    echo "WARNING: System load average is high at $LOAD_AVG"
fi
Explanation:

This script monitors CPU, memory, and disk usage. It compares the current usage against predefined thresholds.
If the system load or resource usage exceeds the threshold, it sends a warning message.
4. Log Rotation Script
This script automates log rotation by compressing old log files and keeping the most recent files. It also deletes logs older than a certain age.

bash
Copy code
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
Explanation:

This script finds logs larger than 10MB and compresses them using gzip.
It also deletes logs older than 30 days to free up space.
5. Server Health Check Script
This script checks the health of a server by performing several checks, including uptime, memory usage, disk usage, and running processes.

bash
Copy code
#!/bin/bash

# Check uptime
UPTIME=$(uptime -p)
echo "Server Uptime: $UPTIME"

# Check memory usage
MEMORY=$(free -h | grep Mem | awk '{print $3 "/" $2}')
echo "Memory Usage: $MEMORY"

# Check disk usage
DISK=$(df -h | grep '^/dev' | awk '{print $5 " " $1}')
echo "Disk Usage: $DISK"

# Check for running processes
PROCESS_COUNT=$(ps aux --no-heading | wc -l)
echo "Running Processes: $PROCESS_COUNT"

# Check CPU load
CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "CPU Load: $CPU_LOAD%"

# Check for failed services (on a systemd-based system)
FAILED_SERVICES=$(systemctl --failed --quiet --no-pager)
if [ -z "$FAILED_SERVICES" ]; then
    echo "All services are running fine."
else
    echo "There are failed services:"
    echo "$FAILED_SERVICES"
fi

  
