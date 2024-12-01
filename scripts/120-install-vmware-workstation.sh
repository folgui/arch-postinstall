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

PKG_VMWARE=(
'ncurses5-compat-libs'
'vmware-workstation'
'fuse2'
'gtkmm'
'libcanberra'
'pcsclite'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

# resolution issues Jan/2023
# VBoxManage setextradata "Your Virtual Machine Name" "VBoxInternal2/EfiGraphicsResolution" "2560x1440"
# VBoxManage setextradata "Your Virtual Machine Name" "VBoxInternal2/EfiGraphicsResolution" "1920x1080"
# graphical driver - VMSVGA !
# see : https://wiki.archlinux.org/title/VirtualBox#Set_guest_starting_resolution

print_title "INSTALL VMWARE VIRTUALBOX VIRTUALIZATION"

chkvbox=$(systemd-detect-virt)
if [ $chkvbox = "none" ]; then
    msg_info "Checking if kernel headers are installed"
    if pacman -Qi linux-headers &> /dev/null; then
        msg_success "linux-headers are already installed"
    else
        sudo pacman -S --noconfirm --needed linux-headers
    fi

    msg_info "Installing packages ..."
    sudo pacman -S --noconfirm --needed ${PKG_VMWARE[@]}
    #sudo pacman -S --noconfirm --needed ncurses5-compat-libs
    #sudo pacman -S --noconfirm --needed vmware-workstation
    #sudo pacman -S --noconfirm --needed fuse2
    #sudo pacman -S --noconfirm --needed gtkmm
    #sudo pacman -S --noconfirm --needed libcanberra
    #sudo pacman -S --noconfirm --needed pcsclite

    msg_info "Starting your VMWare network service to have network connection"
    #sudo systemctl enable vmware-networks.service
    #sudo systemctl start vmware-networks.service
    systemctl start --now vmware-networks-configuration.service
    systemctl is-enabled --quiet vmware-networks.service || sudo systemctl enable vmware-networks.service
    systemctl is-active --quiet vmware-networks.service || sudo systemctl start vmware-networks.service
    systemctl is-enabled --quiet vmware-usbarbitrator.service || sudo systemctl enable vmware-usbarbitrator.service
    systemctl is-active --quiet vmware-usbarbitrator.service || sudo systemctl start vmware-usbarbitrator.service

    modprobe -a vmw_vmci vmmon

    msg_info "You must reboot now"
else
    msg_failed "You are on a virtual machine, skipping VMWare Workstation"
fi

print_done

exit 0
