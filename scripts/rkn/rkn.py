#!/usr/bin/env python3
# -*- coding: <encoding name> -*-

import io
import csv
import itertools
import operator
import sys
import socket


def rkn_read(file_obj):
    csv.field_size_limit(1000000)
    ips = []
    nets = []
    fieldnames = ['ip', 'domain', 'url', 'who', 'doc', 'date']
    reader = csv.DictReader(file_obj, delimiter=';', fieldnames=fieldnames)
    for line in reader:
        addrs = line['ip'].split(" | ")
        for addr in addrs:
            if "/" in addr:
                nets.append(addr)
            elif "." in addr:
                ips.append(addr)
    return ips, nets

def uniq_ip(addrs):
    tmp = []
    for addr in addrs:
        tmp.append(socket.inet_aton(addr)[0])
    return tmp

if __name__ == "__main__":
    with io.open("z-i/dump.csv", encoding='cp1251') as f_obj:
        blocked = rkn_read(f_obj)
#    for ip in blocked[1]:
#        print(ip)
    ips = uniq_ip(blocked[0])
    for ip in ips:
        print(ip)
