#!/bin/bash

rocky_machine_ip="192.168.2.42"

for port in $(seq 8080 8120); do
    nc -w 1 "$rocky_machine_ip" "$port"
    if [ $? -eq 0 ]; then
        echo "Porta $port aperta"
    fi
done

