#!/bin/bash
#i know this script looks ugly lmao

if [ "$1" != "-s" ]; then
  echo "This script will now pacstrap /mnt with base base-devel linux linux-firmware, it will also install git, vim and ranger, after pacstrap is done it will chroot into mnt and install grub, network manager and it will set up a user too"
  echo ""
  read -n 1 -s -r -p "Press any key to continue"
else
  echo "$0: Speed mode is activated"
  sleep 1
 fi
 
pacstrap /mnt base base-devel linux linux-firmware vim git ranger
echo ""
echo ""
echo "GENERATING FSTAB"
genfstab -U /mnt > /mnt/etc/fstab
echo "$0: CHROOTING"
arch-chroot /mnt bash -c '
echo ""
echo "$0 INSTALLING GRUB AND NETWORKMANAGER"
pacman -S grub networkmanager
if [ "$2" != "-f" ]; then
  echo ""
  echo ""
  lsblk
  echo ""
  read -p "What device do you want grub to be installed? (DON'T USE THE PARTITION!): " dev
  grub-install /dev/$dev
else
  grub-install /dev/sda
fi
grub-mkconfig -o /boot/grub/grub.cfg
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
'
echo "$0: System will reboot in 5 seconds, press CTRL + C to cancel (will exit script)"
reboot
