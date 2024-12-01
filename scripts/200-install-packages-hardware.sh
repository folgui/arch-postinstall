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

PKG_HARDWARE=(
  'amd-ucode'
  'chaotic-aur/cpupower-gui'
  'chaotic-aur/cpu-x'
  'dmidecode'
  'chaotic-aur/edid-decode-git'
  'fwupd'
  'gnome-firmware'
  'gsmartcontrol'
  'chaotic-aur/hardinfo'
  'chaotic-aur/hw-probe'
  'folgui/i-nex'
  'inxi'
  'joyutils'
  'lm_sensors'
  'lshw'
  'nvme-cli'
  'chaotic-aur/openrgb'
  'psensor'
  'smartmontools'
  'chaotic-aur/upd72020x-fw'
  'usbutils'
  'wmctrl'
)

PKG_ANDROID=(
  'android-file-transfer'
  'android-tools'
  'android-udev'
  'libmtp'
  'mtpfs'
)

PKG_LOGITECH=(
  'folgui/g810-led-git'
  'folgui/g910-gkeys-git'
  'folgui/g9xled'
  'folgui/gkeybind'
  'folgui/keyleds'
  'folgui/keyboard-center'
  'libratbag'
  'chaotic-aur/logiops'
  'folgui/ltunify'
  'piper'
  'solaar'
)

PKG_DNIE=(
  'opensc'
  'ccid'
  'pcsclite'
  'pcsc-tools'
  'ca-certificates'
  'ca-certificates-utils'
  'ca-certificates-mozilla'
  'ca-certificates-cacert'
  'ca-certificates-dnie'
  'ca-certificates-fnmt'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING HARDWARE RELATED PACKAGES"

msg_info "Installing HARDWARE generic packages"
sudo pacman --noconfirm --needed -S ${PKG_HARDWARE[@]}

msg_info "Installing ANDROID packages"
sudo pacman --noconfirm --needed -S ${PKG_ANDROID[@]}

msg_info "Installing LOGITECH packages"
sudo pacman --noconfirm --needed -S ${PKG_LOGITECH[@]}

msg_info "Installing DNIE packages"
sudo pacman -S --noconfirm --needed ${PKG_DNIE[@]}
msg_info "Enabling and starting DNIE services"
#sudo systemctl enable pcscd.service
#sudo systemctl start pcscd.service
systemctl is-enabled --quiet pcscd.service || sudo systemctl enable pcscd.service
systemctl is-active --quiet pcscd.service || sudo systemctl start pcscd.service

msg_info "Con esto podrás comprobar en la terminal si tu lector funciona correctamente y lee el DNIe."
msg_info "Sólo tienes que conectar todo y ejecutar el comando: pcsc_scan"

msg_info "Adding user to plugdev group"
user=$(who | cut -d ' ' -f1 | uniq)
getent group plugdev || sudo groupadd plugdev
#sudo usermod -a -G plugdev $user
sudo gpasswd -a $user plugdev

print_done

exit 0
