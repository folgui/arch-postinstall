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

PKG_STEAM=(
  'steam'
  '#steam-native-runtime'
  'amdvlk'
  'lib32-amdvlk'
  'lib32-systemd'
  'chaotic-aur/linux-steam-integration'
  'folgui/portproton'
  'gamescope'
  'folgui/protondb-tags'
  'chaotic-aur/proton-caller'
  'chaotic-aur/proton-ge-custom'
  'chaotic-aur/protonup-qt'
  'chaotic-aur/steamcmd'
  'chaotic-aur/steam-rom-manager-git'
  'chaotic-aur/ttf-ms-fonts'
  'ttf-liberation'
  'vulkan-tools'
)

PKG_EMULATION=(
  'chaotic-aur/cemu-git'
  'folgui/emulationstation-de'
  'chaotic-aur/dolphin-emu-avx-git'
  'chaotic-aur/duckstation-avx-git'
  '#chaotic-aur/pegasus-frontend-git'
  'chaotic-aur/pcsx2-avx-git'
  'folgui/ps3netsrv'
  'chaotic-aur/rpcs3-git'
  'folgui/rpcs3-udev'
  'chaotic-aur/ryujinx'
  'chaotaic-aur/shadps4-git'
  'chaotic-aur/simple64'
  'chaotic-aur/vita3k-git'
)

PKG_EMULATION_MAME=(
  'folgui/clrmamepro'
  'folgui/kmame-git'
  'mame'
  'mame-tools'
  'qmc2'
)

PKG_EMULATION_RETROARCH=(
  'retroarch'
  '#retroarch-assets-ozone'
  '#retroarch-assets-xmb'
  'chaotic-aur/retroarch-autoconfig-udev-git'
  'chaotic-aur/librashader'
)

PKG_GAMES=(
  'chaotic-aur/gamehub'
  'lutris'
  'chaotic-aur/heroic-games-launcher-bin'
  'umu-launcher'
)

PKG_TOOLS=(
  'gamemode'
  'lib32-gamemode'
  'gamescope'
  'goverlay'
  'mangohud'
  'lib32-mangohud'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING GAMING PACKAGES"

msg_info "Installing steam packages"
sudo pacman --needed --noconfirm -S ${PKG_STEAM[@]}

msg_info "Installing emulation packages"
sudo pacman --needed --noconfirm -S ${PKG_EMULATION[@]}
sudo pacman --needed --noconfirm -S ${PKG_EMULATION_MAME[@]}
sudo pacman --needed --noconfirm -S ${PKG_EMULATION_RETROARCH[@]}

msg_info "Installing game packages"
sudo pacman --needed --noconfirm -S ${PKG_GAMES[@]}

msg_info "Adding user to gaming related groups"
sudo usermod -a -G video folgui
sudo usermod -a -G gamemode folgui

print_done

exit 0
