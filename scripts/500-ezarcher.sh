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

PKG_EZARCH=(
aisleriot
audacious
audacious-plugins
cdrdao
dvd+rw-tools
dvdauthor
geany
gnome-disk-utility
gnome-keyring
gnome-nettool
grsync
guvcview
guvcview-common
gvfs
gvfs-afc
gvfs-goa
gvfs-gphoto2
gvfs-mtp
gvfs-nfs gvfs-smb
k3b
keepassxc
mpv
qbittorrent
smplayer
)

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

print_title "EZARCHER CLEANUP SCRIPT"

msg_info "Removing unwanted packages from EZARCHER"
sudo pacman -Rns --noconfirm ${PKG_EZARCHE[@]}

# If installation with EZArcher, change to Archlinux
if grep -q ezarcher /etc/default/grub; then
    sudo sed -i "s/^GRUB_DISTRIBUTOR='ezarcher'/GRUB_DISTRIBUTOR='Arch'/g" /etc/default/grub
fi

msg_info "Removing ezmaint script"
# Falta la carpeta que ahora mismo no sé donde está ubicada
sudo rm /usr/share/applications/ezmaint.desktop

# Creo que EZARCHER no cambia el os-release
if grep -q "ezarcher" /etc/os-release; then

fi

print_done

# exit the right way
exit 0


