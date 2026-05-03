#!/bin/bash

check_service() {
    if pgrep -x "$1" > /dev/null
    then
        echo "Service $1 is running"
    else
        echo "Service $1 is not running"
    fi
}

for service in nginx apache mysql redis
do
    echo "------------------------"
    echo "Checking $service..."
    check_service "$service"
done
