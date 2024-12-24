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


