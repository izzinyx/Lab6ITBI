#!/bin/bash
ip=$1;
host=$2;
dns_used=$3;

canread=0;
cat /etc/hosts | while read -r ipv hostv restv; do
    if [[ "$ipv" == "#lab5" ]]; then
        canread=1;
        continue
    fi
    if [[ "$canread" == "1" ]];then
        dns_ip=$(nslookup "$host" "$dns_used" 2>/dev/null | awk '/^Address: / { print $2}')
        if [[ "$dns_ip" != "$ip" ]]; then
            echo "Bogus IP for $host in /etc/hosts!"
        fi
    fi
done
