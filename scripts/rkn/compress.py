#!/usr/bin/env python3
# -*- coding: <encoding name> -*-

import ipaddress


if __name__ == "__main__":
    ips = open("ips.list", "r").read()
    nlist = [ipaddress.IPv4Address(addr) for addr in ips.split()]
    collapsed = ipaddress.collapse_addresses(nlist)
    nets = open("nets.list", "a")
    for addr in collapsed:
        print(addr, file=nets)
