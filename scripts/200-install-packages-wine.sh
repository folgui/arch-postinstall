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

PKG_WINE=(
  'chaotic-aur/ttf-ms-fonts'
  'chaotic-aur/wine-staging-wow64'
  'wine-gecko'
  'wine-mono'
  'winetricks'
  'chaotic-aur/bottles'
  'chaotic-aur/playonlinux'
  'chaotic-aur/q4wine-git'
  'chaotic-aur/wine-installer'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING WINE PACKAGES"

msg_info "Installing wine packages"
sudo pacman --needed --noconfirm -S ${PKG_WINE[@]}
# sudo pacman -S --noconfirm --needed wine
# sudo pacman -S --noconfirm --needed wine_gecko
# sudo pacman -S --noconfirm --needed wine-mono
# sudo pacman -S --noconfirm --needed chaotic-aur/bottles
# sudo pacman -S --noconfirm --needed chaotic-aur/playonlinux

#msg_info "Wayland support requires setting a registry variable. See Wine 9.0 Changelog."
#wine reg.exe add HKCU\\Software\\Wine\\Drivers /v Graphics /d x11,wayland

msg_info "Enabling font smoothing"
cat <<EOF >/tmp/fontsmoothing
REGEDIT4

[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"FontSmoothingOrientation"=dword:00000001
"FontSmoothingType"=dword:00000002
"FontSmoothingGamma"=dword:00000578
EOF

WINE=${WINE:-wine} WINEPREFIX=${WINEPREFIX:-$HOME/.wine} $WINE regedit /tmp/fontsmoothing 2>/dev/null

msg_info "Now, you can run 'wine winecfg' and the configuration panel for WINE will load"

print_done

exit 0
