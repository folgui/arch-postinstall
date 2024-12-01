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

script_dir=$(dirname $(readlink -f $(basename $PWD)))

source ../BashHelper/config.sh
source ../BashHelper/common.sh

print_title "ADDING REBORN-OS REPOSITORY TO PACMAN.CONF"

if grep -q Reborn-OS /etc/pacman.conf; then
    msg_success "REBORN-OS repository is already in pacman.conf"
else
    msg_info "Getting the latest reborn-os keys and mirrors ..."
    wget https://repo.rebornos.org/RebornOS/rebornos-keyring.pkg.tar.zst
    sudo pacman -U rebornos-keyring.pkg.tar.zst
    sudo wget https://raw.githubusercontent.com/RebornOS-Developers/rebornos-mirrorlist/main/reborn-mirrorlist /etc/pacman.d/reborn-mirrorlist
    sudo chmod 644 /etc/pacman.d/reborn-mirrorlist

    msg_info "Creating backup of /etc/pacman.conf ..."
    sudo cp /etc/pacman.conf /etc/pacman.conf.$DATE_NOW.bak

    msg_info "Appending REBORN-OS repository to /etc/pacman.conf ..."
    echo '

    [Reborn-OS]
    SigLevel = Optional TrustAll
    Include = /etc/pacman.d/reborn-mirrorlist' | sudo tee --append /etc/pacman.conf

    msg_info "Updating pacman repositories ..."
    sudo pacman -Syy
fi

print_done

# exit the right way
exit 0
