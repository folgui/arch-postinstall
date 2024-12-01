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

PKG_TIMESHIFT=(
timeshift
timeshift-autosnap
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING TIMESHIFT FOR SNAPSHOTS IN EXT4"

msg_info "For BTRFS, it's better to use SNAPPER. Checking for EXT4 filesystem."

if 	lsblk -f | grep ext4 > /dev/null 2>&1 ; then
    msg_info "You are using EXT4. Installing timeshift"

    sudo pacman -S --noconfirm --needed ${PKG_TIMESHIFT[@]}
else
    msg_failed "Your system does not have a EXT4 filesystem."
fi

print_done

exit 0
