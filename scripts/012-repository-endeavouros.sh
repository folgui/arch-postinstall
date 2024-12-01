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

print_title "ADDING ENDEAVOUR-OS REPOSITORY TO PACMAN.CONF"

if grep -q endeavouros /etc/pacman.conf; then
    msg_success "ENDEAVOUR-OS repository is already in pacman.conf"
else
    msg_info "Getting the latest endeavour-os keys and mirrors ..."
    sudo wget https://github.com/endeavouros-team/repo/blob/master/endeavouros/x86_64/endeavouros-keyring-20230523-1-any.pkg.tar.zst?raw=true -O /tmp/endeavouros-keyring-20230523-1-any.pkg.tar.zst
    sudo pacman -U --noconfirm --needed /tmp/endeavouros-keyring-20230523-1-any.pkg.tar.zst
    sudo wget https://github.com/endeavouros-team/repo/blob/master/endeavouros/x86_64/endeavouros-mirrorlist-23.4-1-any.pkg.tar.zst?raw=true -O /tmp/endeavouros-mirrorlist-23.4-1-any.pkg.tar.zst
    sudo pacman -U --noconfirm --needed /tmp/endeavouros-mirrorlist-23.4-1-any.pkg.tar.zst

    msg_info "Creating backup of /etc/pacman.conf ..."
    sudo cp /etc/pacman.conf /etc/pacman.conf.$DATE_NOW.bak

    msg_info "Appending ENDEAVOUR-OS repository to /etc/pacman.conf ..."
    echo '

    [endeavouros]
    SigLevel = PackageRequired
    Include = /etc/pacman.d/endeavouros-mirrorlist' | sudo tee --append /etc/pacman.conf

    msg_info "Updating pacman repositories ..."
    sudo pacman -Syy
fi

print_done

# exit the right way
exit 0
