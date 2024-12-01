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

print_title "ADDING CHAOTIC-AUR REPOSITORY TO PACMAN.CONF"

if grep -q chaotic-aur /etc/pacman.conf; then
    msg_success "CHAOTIC-AUR repository is already in pacman.conf"
else
    msg_info "Getting the latest chaotic-aur keys and mirrors ..."
    sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key FBA220DFC880C036
    #wget -O ~/chaotic-keyring.pkg.tar.zst https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst
    #wget -O ~/chaotic-mirrorlist.pkg.tar.zst https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst
    #pacman -U ~/chaotic-keyring.pkg.tar.zst ~/chaotic-mirrorlist.pkg.tar.zst
    sudo pacman -U --noconfirm --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

    msg_info "Creating backup of /etc/pacman.conf ..."
    sudo cp /etc/pacman.conf /etc/pacman.conf.$DATE_NOW.bak

    msg_info "Appending CHAOTIC-AUR repository to /etc/pacman.conf ..."
    echo '

    [chaotic-aur]
    Include = /etc/pacman.d/chaotic-mirrorlist' | sudo tee --append /etc/pacman.conf

    msg_info "Updating pacman repositories ..."
    sudo pacman -Syy
fi

print_done

# exit the right way
exit 0
