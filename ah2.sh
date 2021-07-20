#!/bin/bash

echo "This script will now pacstrap /mnt with base base-devel linux linux-firmware, it will also install git, vim and ranger, after pacstrap is done it will chroot into mnt and install grub, network manager and it will set up a user too"
echo ""
read -n 1 -s -r -p "Press any key to continue"

pacstrap /mnt base base-devel linux linux-firmware vim git ranger
echo ""
echo ""
echo "$0: CHROOTING"
arch-chroot /mnt
echo ""
echo "$0 INSTALLING GRUB AND NETWORKMANAGER"
pacman -S grub networkmanager
echo ""
echo ""
lsblk
echo ""
read -p "What device do you want grub to be installed? (DON'T USE THE PARTITION!): " dev
grub-install /dev/$dev
grub-mkconfig >> /boot/grub/grub.cfg
echo ""
echo "$0: ENABLING NETWORK MANAGER IN SYSTEMD"
systemctl enable NetworkManager.service
echo ""
echo "$0: SETTING USER UP"
echo ""
echo "!! !! SET PASSWORD TO ROOT !! !!"
passwd
echo ""
echo "Creating user now..."
echo "User will be added to the wheels group, remember to edit sudoers file to your liking"
read -p "What username would you like? " username
useradd -mg wheel $username
passwd $username
echo ""
echo ""
echo ""
echo "$0: INSTALATION COMPLETED! Enjoy Arch Linux :)"
echo "$0: Exiting chroot env"
sleep 1
echo "."
sleep 1
echo ".."
sleep 1
echo "..."
sleep 1
exit
echo "$0: System will reboot in 5 seconds, press CTRL + C to cancel (will exit script)"
