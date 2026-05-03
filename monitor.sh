#!/bin/bash

check_service() {
	if [ $1 = "nginx" ] || [ $1 = "apache" ] || [ $1 = "mysql" ]
	then
		echo "Service $1 is active"
	else 
		echo "Service $1 not found"
	fi
}

for service in nginx apache mysql redis
do
	echo "Checking $service.."
	check_service $service
	echo ""
done
