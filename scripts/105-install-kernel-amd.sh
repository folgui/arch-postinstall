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

print_title "INSTALL LINUX-AMD KERNEL"

if pacman -Qi linux-amd  > /dev/null 2>&1 ; then
    msg_success "LINUX-AMD kernel already installed"
else
    if pacman -Si linux-amd > /dev/null 2>&1; then
        msg_info "Installing LINUX-AMD kernel ..."
        sudo pacman -S --noconfirm --needed linux-amd linux-amd-headers
        msg_info "Updating GRUB ..."
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    else
        msg_failed "LINUX-AMD kernel is not in pacman repositories, you must add a repository as CHAOTIC-AUR"
    fi
fi

print_done

exit 0