git@github.com:zapret-info/z-i.git


./rkn.py | sort -u | sed 's/\(.*\)/add address=\1 list=rkn/g' > blocked.rsc

/ip firewall address-list remove [/ip firewall address-list find list="rkn"]

upload it
/import blocked.rsc
