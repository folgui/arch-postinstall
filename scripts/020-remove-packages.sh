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

PKG_REMOVE=(
'adobe-source-han-sans-cn-fonts'
'adobe-source-han-sans-jp-fonts'
'adobe-source-han-sans-kr-fonts'
'archinstall'
'eos-hooks'
'eos-update-notifier'
'mlocate'
'qt5ct'
'qt6ct'
'screenfetch'
'tlp'
'transmission-cli'
'transmission-gtk'
'transmission-qt'
'virtualbox-guest-utils'
'xdg-desktop-portal-gnome'
'xf86-video-amdgpu'
'xf86-video-ati'
'xf86-video-dummy'
'xf86-video-fbdev'
'xf86-video-intel'
'xf86-video-nouveau'
'xf86-video-openchrome'
'xf86-video-qxl'
'xf86-video-vesa'
'xf86-video-vmware'
)

print_title "REMOVING UNNEEDED PACKAGES"

sudo pacman -Rns --noconfirm ${PKG_REMOVE[@]}
#sudo pacman -Rs --noconfirm broadcom-wl-dkms
#sudo pacman -Rs --noconfirm rtl8821cu-morrownr-dkms-git
#sudo pacman -Rs --noconfirm neofetch

print_done

# exit the right way
exit 0



