#!/bin/bash

echo
tput setaf 3
echo "################################################################"
echo "################### Kernel XANMOD"
echo "################################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed chaotic-aur/linux-xanmod chaotic-aur/linux-xanmod-headers
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo
tput setaf 6
echo "################################################################"
echo "################### Done"
echo "################################################################"
tput sgr0
echo
