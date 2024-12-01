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

PKG_XORG=(
'xorg'
'xorg-apps'
'xorg-drivers'
'xorg-fonts'
'xorg-xkill'
'xterm'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALL XORG DISPLAY SERVER"

msg_info "Installing packages ..."
sudo pacman -S --noconfirm --needed ${PKG_XORG[@]}
# sudo pacman -S --noconfirm --needed xorg
# sudo pacman -S --noconfirm --needed xorg-apps
# sudo pacman -S --noconfirm --needed xorg-drivers
# sudo pacman -S --noconfirm --needed xorg-fonts
# sudo pacman -S --noconfirm --needed xorg-xkill
# sudo pacman -S --noconfirm --needed xterm

print_done

exit 0
