#!/bin/bash
#set -e
##################################################################################################################
# Script    : setup_sysctl
# Author    : Jose Miguel Folgueira
# Website   : https://folgui.synology.me/
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

# Default HOOKS in /etc/mkinitcpio.conf:
# HOOKS=(base udev autodetect kms modconf block keyboard keymap consolefont filesystems fsck)
# ArchWiki recommends putting microcode after autodetect hook
# Put script in /usr/local/bin

echo
tput setaf 4
echo "##############################################"
echo "### UPDATING /etc/sysctl.d/99-sysctl.conf  ###"
echo "##############################################"
tput sgr0
echo

sudo cp ./99-sysctl.conf /etc/sysctl.d/

echo
tput setaf 6
#echo "############"
echo "### DONE ###"
#echo "############"
tput sgr0
echo

