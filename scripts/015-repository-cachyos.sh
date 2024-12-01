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

print_title "ADDING CACHYOS REPOSITORY TO PACMAN.CONF"

if grep -q cachyos /etc/pacman.conf; then
    msg_success "CACHYOS repository is already in pacman.conf"
else
    msg_info "Getting the latest cachyos keys and mirrors ..."
    sudo pacman-key --recv-key F3B607488DB35A47 --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key F3B607488DB35A47
    sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-18-1-any.pkg.tar.zst' \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-18-1-any.pkg.tar.zst' \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-6-1-any.pkg.tar.zst'

    msg_info "Creating backup of /etc/pacman.conf ..."
    sudo cp /etc/pacman.conf /etc/pacman.conf.$DATE_NOW.bak

    msg_info "Appending CACHYOS repository to /etc/pacman.conf ..."
    ## Only add this, if your CPU supports the x86-64-v4 architecture
    ## Check with: /lib/ld-linux-x86-64.so.2 --help | grep supported
    echo '

[cachyos-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-core-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos-extra-v4]
Include = /etc/pacman.d/cachyos-v4-mirrorlist
[cachyos]
Include = /etc/pacman.d/cachyos-mirrorlist' | sudo tee --append /etc/pacman.conf

    msg_info "Updating pacman repositories ..."
    sudo pacman -Syy
fi

print_done

# exit the right way
exit 0
