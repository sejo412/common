#!/usr/bin/env python3
# -*- coding: <encoding name> -*-

import io
import csv


def rkn_read(file_obj):
    addresses = []
    fieldnames = ['ip', 'domain', 'url', 'who', 'doc', 'date']
    reader = csv.DictReader(file_obj, delimiter=';', fieldnames=fieldnames)
    for line in reader:
        ips = line['ip'].split(" | ")
        for ip in ips:
            if "Updated" not in ip:
                addresses.append(ip)
    return addresses


if __name__ == "__main__":
    with io.open("z-i/dump.csv", encoding='cp1251') as f_obj:
        blocked = rkn_read(f_obj)
    for ip in blocked:
        print(ip)
