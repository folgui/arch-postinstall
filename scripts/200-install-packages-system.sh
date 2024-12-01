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

PKG_SYSTEM=(
  'folgui/chkservice'
  'cifs-utils'
  'cockpit'
  'cockpit-machines'
  'cockpit-packagekit'
  'cockpit-storaged'
  'cronie'
  'folgui/cylon'
  'ddrescue'
  'folgui/ddrescue-gui'
  'chaotic-aur/downgrade'
  'folgui/efibooteditor'
  'efibootmgr'
  'etc-update'
  'foremost'
  'fuseiso'
  'gnome-disk-utility'
  'gparted'
  #grub-customizer
  'folgui/grub2-theme-preview'
  'arcolinux_repo/archlinux-kernel-manager'
  'lfs'
  'lsb-release'
  'chaotic-aur/memtest86-efi'
  'os-prober'
  'folgui/pyakm'
  'procs'
  'chaotic-aur/stacer'
  'systemdgenie'
  'chaotic-aur/systemd-manager-git'
  'systemd-ui'
  'testdisk'
  'chaotic-aur/update-grub'
  'zps'
  'cachyos/cachyos-sysctl-manager'
  'cachyos/cachy-chroot'
)

PKG_FIRMWARE=(
  'chaotic-aur/aic94xx-firmware'
  'chaotic-aur/wd719x-firmware'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING SYSTEM PACKAGES"

msg_info "Installing firmware packages"
sudo pacman --noconfirm --needed -S ${PKG_FIRMWARE[@]}

msg_info "Installing system packages"
sudo pacman --noconfirm --needed -S ${PKG_SYSTEM[@]}

print_done

exit 0
