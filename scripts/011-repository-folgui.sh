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

source ../BashHelper/config.sh
source ../BashHelper/common.sh

print_title "ADDING FOLGUI'S PERSONAL REPOSITORY TO PACMAN.CONF"

if grep -q folgui /etc/pacman.conf; then
    msg_success "FOLGUI's repository is already in pacman.conf"
else
    msg_info "Creating backup of /etc/pacman.conf ..."
    sudo cp /etc/pacman.conf /etc/pacman.conf.$DATE_NOW.bak

    msg_info "Appending FOLGUI's repository to /etc/pacman.conf ..."
    echo '

    # Maintainer: folgui <folguidroid@gmail.com>
    [folgui]
    SigLevel = Optional TrustAll
    #Server = file:///run/media/Diskstation/Web/folgui_archrepo/
    #Server = file:///home/folgui/folgui-aur/$arch
    Server = https://folgui.synology.me/folgui_archrepo/$arch' | sudo tee --append /etc/pacman.conf

    msg_info "Updating pacman repositories ..."
    sudo pacman -Syy
fi

print_done

# exit the right way
exit 0
