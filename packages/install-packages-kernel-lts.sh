#!/bin/bash

echo
tput setaf 3
echo "################################################################"
echo "################### Kernel LTS"
echo "################################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed linux-lts linux-lts-headers
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo
tput setaf 6
echo "################################################################"
echo "################### Done"
echo "################################################################"
tput sgr0
echo
