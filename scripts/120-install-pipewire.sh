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

PKG_PIPEWIRE=(
'easyeffects'
'pipewire'
'pipewire-alsa'
'pipewire-audio'
'pipewire-docs'
'pipewire-jack'
'pipewire-pulse'
'pipewire-session-manager'
'pipewire-v4l2'
'wireplumber'
'wireplumber-docs'
'libpipewire'
'libwireplumber'
'gst-plugin-pipewire'
'kpipewire'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALL PIPEWIRE"

msg_info "Installing pipewire packages"
sudo pacman -S --noconfirm --needed ${PKG_PIPEWIRE[@]}
# sudo pacman -S --noconfirm --needed easyeffects
# sudo pacman -S --noconfirm --needed pipewire
# sudo pacman -S --noconfirm --needed pipewire-alsa
# sudo pacman -S --noconfirm --needed pipewire-audio
# sudo pacman -S --noconfirm --needed pipewire-docs
# sudo pacman -S --noconfirm --needed pipewire-jack
# sudo pacman -S --noconfirm --needed pipewire-pulse
# sudo pacman -S --noconfirm --needed pipewire-session-manager
# sudo pacman -S --noconfirm --needed pipewire-v4l2
# sudo pacman -S --noconfirm --needed wireplumber
# sudo pacman -S --noconfirm --needed wireplumber-docs
# sudo pacman -S --noconfirm --needed libpipewire
# sudo pacman -S --noconfirm --needed libwireplumber
## sudo pacman -S --noconfirm --needed lib32-libpipewire
## sudo pacman -S --noconfirm --needed lib32-pipewire
## sudo pacman -S --noconfirm --needed lib32-pipewire-jack
## sudo pacman -S --noconfirm --needed lib32-pipewire-v4l2
# sudo pacman -S --noconfirm --needed gst-plugin-pipewire
# sudo pacman -S --noconfirm --needed kpipewire
##sudo pacman -S --noconfirm --needed qemu-audio-pipewire

print_done

exit 0
