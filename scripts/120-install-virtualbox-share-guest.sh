#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-

#DEBUG
#set -x ## Use “set -x” to enable debug mode
#set -e ## Use "set -e" to exit on error
set -u ## Use "set -u" alway to make sure you won't use any undeclared variable. This saves you from a lot of headaches and critical bugs.

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

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "AUTOMOUNT SHARED FOLDERS FOR VIRTUALBOX IN GUEST"

chkvbox=$(systemd-detect-virt)
if [ $chkvbox = "oracle" ]; then
    msg_info "Installing virtualbox-guest-utils"
    sudo pacman -S virtualbox-guest-utils
    user=$(who | cut -d ' ' -f1 | uniq)
    service='vboxservice.service'

    sudo gpasswd -a $user vboxsf

    msg_info "Checking if virtualbox service is enabled and active"
    systemctl is-enabled --quiet $service || sudo systemctl enable $service
    systemctl is-active --quiet $service || sudo systemctl start $service

    msg_info "Now log out and log back in."
    msg_info "If you have set virtualbox to share a folder with automount, it will appear in the filemanager at next login"
else
    msg_failed "You are not on a VirtualBox virtual machine, skipping"
fi

print_done

exit 0
