#!/bin/bash
#this script assumes you only want to install arch in sda with only one partition, this will automate the entire arch installation

echo "WARNING: THIS WILL AUTOMATE THE ENTIRE ARCH LINUX INSTALL, IT WILL USE SDA AS THE INSTALL DEVICE AND IT WILL USE ONLY ONE PARTITION, IT WILL STILL SHOW YOU TO USE CFDISK, CREATING MORE THAN ONE PARTITION WON'T BE ANY USE"
read -n 1 -s -r -p "PRESS ANY KEY IF YOU WANT TO CONTINUE"
sleep 1
echo "."
sleep 1
echo ".."
sleep 1
echo "..."
sleep 1
clear

echo "Opening cfdisk /dev/sda"

cfdisk /dev/sda
clear

mkfs.ext4 /dev/sda1

umount -R /mnt
mount /dev/sda1 /mnt

echo "This script will now run ah2.sh in 3 seconds"
sleep 3
bash ah2.sh -s -f
