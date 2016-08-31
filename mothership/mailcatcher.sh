#!/bin/sh

IP_ADDR=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
exec mailcatcher --http-port 1080 --http-ip $IP_ADDR