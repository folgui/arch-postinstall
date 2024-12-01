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

print_title "INSTALL ARCHLINUX LTS KERNEL"

if pacman -Qi linux-lts; then
    msg_success "Archlinux LTS kernel already installed"
else
    msg_info "Installing Archlinux LTS kernel ..."
    sudo pacman -S --noconfirm --needed linux-lts linux-lts-headers
    msg_info "Updating GRUB ..."
    sudo grub-mkconfig -o /boot/grub/grub.cfg
fi

print_done

exit 0
