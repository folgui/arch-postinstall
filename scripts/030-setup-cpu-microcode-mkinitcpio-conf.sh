#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-

#DEBUG
#set -x ## Use “set -x” to enable debug mode
#set -e ## Use "set -e" to exit on error
set -u  ## Use "set -u" alway to make sure you won't use any undeclared variable. This saves you from a lot of headaches and critical bugs.

# ============================================================================ #
# @author       : Copyright (c) 202x Jose Miguel Folgueira <a.k.a. folgui>
# @email        : folguidroid@gmail.com
# @web          : http://folgui.synology.me/
# @github       : https://github.com/folgui
# @style        : https://gitlab.com/fryntiz/bash-guide-style
# @license      : https://www.mit.edu/~amini/LICENSE.md
#
# Project Name  :
# Description   :
# Version       :
# ============================================================================ #

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

# Default HOOKS in /etc/mkinitcpio.conf:
# HOOKS=(base udev autodetect kms modconf block keyboard keymap consolefont filesystems fsck)
# ArchWiki recommends putting microcode after autodetect hook

print_title "INSTALLING THE CORRECT MICROCODE - INTEL OR AMD"

#cpu=$(lscpu | awk '/Vendor ID:/ {print $3}')
cpu=$(cat /proc/cpuinfo | grep vendor_id | uniq | awk '{print $3}')

msg_info "We are installing the package for this CPU: $cpu"
blank_line
blank_line

if [[ $cpu == AuthenticAMD ]]; then
  sudo pacman -Rns intel-ucode 2> /dev/null
  sudo pacman -S --noconfirm --needed amd-ucode
elif [[ $cpu == GenuineIntel ]]; then
  sudo pacman -Rns amd-ucode 2> /dev/null
  sudo pacman -S --noconfirm --needed intel-ucode
fi

blank_line

if grep -q microcode /etc/mkinitcpio.conf; then
  msg_success "microcode is already in mkinitcpio.conf"
else
  msg_info "Creating backup of /etc/mkinitcpio.conf ..."
  sudo cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.$DATE_NOW.bak
  msg_info "Adding microcode to /etc/mkinicpio.conf before autodetect ..."
  sudo sed -i "s/^HOOKS=(base udev autodetect/HOOKS=(base udev autodetect microcode/g" /etc/mkinitcpio.conf
  sudo mkinitcpio -P
fi

print_done

exit 0



