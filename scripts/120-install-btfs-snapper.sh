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

PKG_SNAPPER=(
'btrfs-assistant'
'btrfsmaintenance'
'grub-btrfs'
'snap-pac'
'snapper'
'snapper-gui-git'
'snapper-support'
'snapper-tools'
'btrfs-du'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "BTRFS WITH SNAPPER FOR SNAPSHOTS"

if 	lsblk -f | grep btrfs > /dev/null 2>&1 ; then
    msg_info "You are using BTRFS. Installing the snapper software ..."
    sudo pacman -S --noconfirm --needed ${PKG_SNAPPER[@]}
    sudo pacman -S --noconfirm --needed chaotic-aur/btrfs-assistant
    sudo pacman -S --noconfirm --needed chaotic-aur/btrfsmaintenance
    sudo pacman -S --noconfirm --needed grub-btrfs
    sudo pacman -S --noconfirm --needed snap-pac
    #sudo pacman -S --noconfirm --needed snap-sync
    sudo pacman -S --noconfirm --needed snapper
    sudo pacman -S --noconfirm --needed chaotic-aur/snapper-gui-git
    sudo pacman -S --noconfirm --needed snapper-support
    sudo pacman -S --noconfirm --needed chaotic-aur/snapper-tools
    sudo pacman -S --noconfirm --needed arcolinux_repo_3party/btrfs-du

    msg_info "Creating first manual root filesystem snapshot"
    sudo snapper -c root create-config /
    snapper -c root create --description "initial snapshot"
    sudo chmod a+rx /.snapshots
    sudo chown :users /.snapshots
else
    msg_failed "Your system does not have a BTRFS filesystem"
fi

print_done

exit 0
