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

PKG_SYSTEMDBOOT=(
    '#chaotic-aur/systemd-boot-pacman-hook'
    'chaotic-aur/kernel-install-mkinitcpio'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "Tools for systemd-boot boot manager"

msg_info "Installing systemd-boot packages ..."
sudo pacman -S --noconfirm --needed ${PKG_SYSTEMDBOOOT[]@]}

msg_info "Reinstalling Kernels"
sudo reinstall-kernels

print_done

exit 0
