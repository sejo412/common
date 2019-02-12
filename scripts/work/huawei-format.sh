#!/bin/bash

set -e

prefix=$(hostname -f | awk -F'-|\.' '{print $1"_"$3"_"$4"_v"}')

vol=0

for disk in $(lsblk -r | awk '/^sd/ {print $1}' | grep -v "$(cat /proc/mdstat | awk '/md/ {print $5}' | sed 's/[0-9]\[[0-9]\]//' | uniq)$" | grep -v "$(cat /proc/mdstat | awk '/md/ {print $6}' | sed 's/[0-9]\[[0-9]\]//' | uniq)$" | grep -v -e "[0-9]$"); do
  mkfs.xfs -f -L "${prefix}${vol}" /dev/${disk}
  mkdir -p /vstorage/vol${vol}
  echo "LABEL=${prefix}${vol} /vstorage/vol${vol} xfs rw,noatime,nodiratime,attr2,inode64,noquota 0 0" >> /etc/fstab
  let vol=vol+1
done

udevadm trigger
mount -a
