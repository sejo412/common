#!/usr/local/bin/bash

echo "Updating rules..."

rm -f dirty.list ips.list nets.list

echo "/ip firewall address-list remove [/ip firewall address-list find list=\"rkn\"]" > blocked.rsc
echo "/ip firewall address-list" >> blocked.rsc

iconv -f cp1251 -t utf8 z-i/dump.csv | cut -d";" -f1 | tr '|' '\n' |  tr -d ' ' | egrep -v "(Updated|^$)" | sort -uV > dirty.list

grep -v "/" dirty.list > ips.list
grep "/" dirty.list > nets.list
rm -f dirty.list

./compress.py

rm -f ips.list
sed -i 's/\/32//g' nets.list
sed 's/\(.*\)/add address=\1 list=rkn/g' nets.list >> blocked.rsc
rm -f nets.list
scp blocked.rsc admin@192.168.88.1:/disk1/
ssh admin@192.168.88.1 "import /disk1/blocked.rsc"
