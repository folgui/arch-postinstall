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

PKG_QEMU=(
'virtualbox'
'virtualbox-host-dkms'
'virtualbox-ext-oracle'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

# resolution issues Jan/2023
# VBoxManage setextradata "Your Virtual Machine Name" "VBoxInternal2/EfiGraphicsResolution" "2560x1440"
# VBoxManage setextradata "Your Virtual Machine Name" "VBoxInternal2/EfiGraphicsResolution" "1920x1080"
# graphical driver - VMSVGA !
# see : https://wiki.archlinux.org/title/VirtualBox#Set_guest_starting_resolution

print_title "INSTALL VIRTUALBOX VIRTUALIZATION"

chkvbox=$(systemd-detect-virt)
if [ $chkvbox = "none" ]; then
    msg_info "Checking if kernel headers are installed"
    if pacman -Qi linux-headers &> /dev/null; then
        msg_success "linux-headers are already installed"
    else
        sudo pacman -S --noconfirm --needed linux-headers
    fi

    msg_info "Installing packages ..."
    sudo pacman -S --noconfirm --needed ${PKG_VIRTUALBOX[@]}
    # sudo pacman -S --noconfirm --needed virtualbox
    # sudo pacman -S --noconfirm --needed virtualbox-host-dkms
    # sudo pacman -S --noconfirm --needed virtualbox-ext-oracle
    # Replaces virtualbox package with one with KVM backend: https://github.com/cyberus-technology/virtualbox-kvm
    # sudo pacman -S --noconfirm --needed virtualbox-kvm
    # IN GUEST:
    # sudo pacman -S --noconfirm --needed virtualbox-guest-iso
    # sudo pacman -S --noconfirm --needed virtualbox-guest-utils

    msg_info "Adding user to vboxusers group"
	user=$(whoami)
	sudo gpasswd -a $user vboxusers

	msg_info "Removing all the messages virtualbox produces"
	VBoxManage setextradata global GUI/SuppressMessages "all"
else
    msg_failed "You are on a virtual machine, skipping VirtualBox"
fi

print_done

exit 0
