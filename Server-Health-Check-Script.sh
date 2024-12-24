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
