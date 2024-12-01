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

PKG_BLUETOOTH=(
'bluedevil'
'bluez'
'bluez-obex'
'bluez-qt'
'bluez-tools'
'bluez-utils'
'hidapi'
'lib32-bluez-plugins'
'libldac'
'qt6-connectivity'
'sbc'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALL BLUETOOTH APPS AND SERVICES"

msg_info "Installing bluetooth packages ..."
sudo pacman -S --noconfirm --needed ${PKG_BLUETOOTH[@]}
#sudo pacman -S --noconfirm --needed bluedevil
#sudo pacman -S --noconfirm --needed bluez
#sudo pacman -S --noconfirm --needed bluez-obex
#sudo pacman -S --noconfirm --needed bluez-qt
#sudo pacman -S --noconfirm --needed bluez-tools
#sudo pacman -S --noconfirm --needed bluez-utils
#sudo pacman -S --noconfirm --needed hidapi
#sudo pacman -S --noconfirm --needed lib32-bluez-plugins
#sudo pacman -S --noconfirm --needed libldac
#sudo pacman -S --noconfirm --needed qt6-connectivity
#sudo pacman -S --noconfirm --needed sbc

# for pipewire, substitutes pulseaudio-bluetooth, installed in pipewire script
#sudo pacman -S --noconfirm --needed pipewire-pulse

msg_info "Enabling and starting bluetooth service ..."
#sudo systemctl enable bluetooth.service
#sudo systemctl start bluetooth.service
systemctl is-enabled --quiet bluetooth.service || sudo systemctl enable bluetooth.service
systemctl is-active --quiet bluetooth.service || sudo systemctl start bluetooth.service

sudo sed -i 's/'#AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf

print_done

exit 0
