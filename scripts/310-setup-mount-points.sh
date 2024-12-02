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

print_title "SETTTING UP MOUNT POINTS"

# Prepare mountpoint with the right permissions
# local mountpoint="/media"
# sudo mkdir -p "$mountpoint"
#sudo chown -R $USER:wheel "$mountpoint"
#sudo chown -R $USER:$USER "$mountpoint"

#msg_success "Now you can mount device at $mountpoint manually or add it to fstab"

# También podrías editar el archivo /usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy poniendo en los 3 primeros (los del primer grupo que salen), yes

#<defaults>
#    <allow_any>yes</allow_any>
#    <allow_inactive>yes</allow_inactive>
#    <allow_active>yes</allow_active>
#</defaults>

# Personal Mountpoints to FSTAB
# if grep -q FOLGUI /etc/fstab; then
#     msg_success "You already have personal mounted points in /etc/fstab"
# else
#     msg_info "Adding personal mountpoints to /etc/fstab"
#     sudo cat "$script_dir/settings/config-etc/fstab-append.txt" >>/etc/fstab
# fi

msg_info "Preparing mountpoints and enabling its systemd units"

local mountpoint="/media"
sudo mkdir -p "$mountpoint"

sudo cp $script_dir/config/mounts/media* /etc/systemd/system

sudo systemctl enable media-DATA.mount
sudo systemctl enable media-WDMYBOOK8.mount
sudo systemctl enable media-Synology-Backup.automount
sudo systemctl enable media-Synology-Biblioteca.automount
sudo systemctl enable media-Synology-Descargas.automount
sudo systemctl enable media-Synology-Docker.automount
sudo systemctl enable media-Synology-Documentos.automount
sudo systemctl enable media-Synology-Fotos.automount
sudo systemctl enable media-Synology-Linux.automount
sudo systemctl enable media-Synology-Misc.automount
sudo systemctl enable media-Synology-Musica.automount
sudo systemctl enable media-Synology-Usb3.automount
sudo systemctl enable media-Synology-Usb.automount
sudo systemctl enable media-Synology-Videos.automount
sudo systemctl enable media-Synology-Web.automount

sudo cp $script_dir/config/mounts/create-symlinks.service /etc/systemd/system
sudo cp $script_dir/config/mounts/create-symlinks.sh /usr/local/bin
sudo systemctl enable create-symlinks.service

print_done

exit 0
