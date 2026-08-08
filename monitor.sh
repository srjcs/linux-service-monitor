#!/bin/bash

LOG_FILE="logs/service-monitor.log"

echo "=================================" | tee -a "$LOG_FILE"
echo "      LINUX SERVICE MONITOR" | tee -a "$LOG_FILE"
echo "Date: $(date)" | tee -a "$LOG_FILE"
echo "=================================" | tee -a "$LOG_FILE"

check_service() {
    if pgrep -x "$1" > /dev/null
    then
        echo "PASS: Service $1 is running" | tee -a "$LOG_FILE"
    else
        echo "WARNING: Service $1 is not running" | tee -a "$LOG_FILE"
    fi
}

check_system_service() {
    if systemctl is-active --quiet "$1"
    then
        echo "PASS: Service $1 is active"
    else
        echo "WARNING: Service $1 is inactive"
    fi
}

for service in nginx apache mysql redis
do
    echo "------------------------" | tee -a "$LOG_FILE"
    echo "Checking $service..." | tee -a "$LOG_FILE"
    check_service "$service"
done

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    check_system_service ssh
    check_system_service docker
    check_system_service nginx
else
    echo "systemctl checks skipped: Linux required" | tee -a "$LOG_FILE"
fi
