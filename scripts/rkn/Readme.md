git@github.com:zapret-info/z-i.git

iconv -f cp1251 -t utf8 z-i/dump.csv | cut -d";" -f1 | grep -v "Updated" | tr '|' '\n' |  tr -d ' ' | sort -u | grep "." | less
iconv -f cp1251 -t utf8 z-i/dump.csv | cut -d";" -f1 | grep -v "Updated" | tr '|' '\n' |  tr -d ' ' | sort -u | grep "." | grep -v "/" > tmp

./rkn.py | sort -u | sed 's/\(.*\)/add address=\1 list=rkn/g' > blocked.rsc

/ip firewall address-list remove [/ip firewall address-list find list="rkn"]

upload it
/import blocked.rsc
