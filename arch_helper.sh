#!/bin/bash
clear

if [ "$1" != "-s" ]; then
	echo "Welcome to Arch Helper made by Dannyxjsu"
	echo "This script makes it easier and faster to install  Arch Linux"
	echo "'Why?' you might ask, well i'm tired of having to manually install Arch over and over again, I just waant to install it a little bit faster whenever I need to install it again"
	echo ""
	read -n 1 -s -r -p "Press any key to continue"
	clear
else
	echo "$0: Speed mode is activated"
fi

lsblk
read -p "Choose device: " dev
dev="/dev/$dev"
echo "Opening cfdisk $dev"

if [ "$1" != "-s" ]; then
	sleep 1
	echo "."
	sleep 1
	echo ".."
	sleep 1
	echo "..."
	sleep 1
fi

cfdisk $dev
cfdisk_exit=$?

if [ "$cfdisk_exit" -ne 0 ]; then
	echo "$0: Failed running cfdisk $dev, make sure you've typed everything right"
	sleep 3
	exit
fi	

clear

echo "Now you can use the command mkfs.ext4 to format the partitions you've created, after you're done, run the command mkswap and then swapon to a swap partition if you have made, if not then don't worry about it, you can mount the partitions how you'd like in /mnt, then run the ah2.sh script"
echo ""
read -n 1 -s -r -p "Press any key to continue"

clear

