#!/bin/bash

while true; do

c_file=$(ls -lt -c /tmp/capture* | sed -n 1P | awk -F" " '{print $9}')
echo ${c_file}
tshark -n -r ${c_file} -l | \
        grep "→" | awk -F" " '{print $3,$5}' | \
        sed -E 's/192\.168\.0\.([0-9]+)/L4_\1/g' | \
        sed -E 's/([0-9a-f]{2,2}:){5}[0-9a-f]{2,2}//g' | \
       sed -E 's/2409:([0-9a-f]*:)+([0-9a-f]+)/L6_\2/g' | \
       sed -E 's/fe80:([0-9a-f]*:)+([0-9a-f]+)//g' | \
        grep [0-9a-f] | grep -v -E 'L.+L' | grep -E 'L[46]' | \
	sort | uniq -c | grep -v -e '^\s*$' | \
        sed -E 's/ +/\,/g' | \
	nc -u -q0 192.168.0.19 1885

	sleep 10
done
