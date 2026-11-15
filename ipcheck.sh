#!/bin/bash

canread=0
cat /etc/hosts | while read -r ip host rest; do
    if [[ "$ip" == "#Lab5" ]]; then
        canread=1;
        continue;
    fi
    if [[ "$canread" == "1" ]]; then
        dns_ip=$(nslookup $host 8.8.8.8 2>/dev/null | awk '/^Address: / { print $2 }')
        if [[ "$dns_ip" != "$ip" ]]; then
            echo "Bogus IP for $host in /etc/hosts!"
        fi
    fi
done
