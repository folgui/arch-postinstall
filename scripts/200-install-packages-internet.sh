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

PKG_INTERNET=(
  'chaotic-aur/anydesk-bin'
  'aria2'
  'filezilla'
  #firefox
  #firefox-i18n-es-es
  'chaotic-aur/firefox-appmenu'
  'chaotic-aur/google-chrome'
  'gufw'
  'iftop'
  'chaotic-aur/ipscan'
  'chaotic-aur/jdownloader2'
  'linssid'
  'nethogs'
  'nmap'
  'openvpn'
  'network-manager-applet'
  'networkmanager'
  'networkmanager-openvpn'
  'opera'
  'openssh'
  'putty'
  'qbittorrent'
  'rclone'
  'chaotic-aur/rclone-browser'
  'speedtest-cli'
  'folgui/synology-assistant'
  'telegram-desktop'
  #thunderbird
  #thunderbird-i18n-es-es
  'chaotic-aur/thunderbird-appmenu'
  'chaotic-aur/tor-browser-bin'
  'traceroute'
  'wireshark-qt'
)

PKG_SYNOLOGY=(
  'folgui/synology-assistant'
  'folgui/synology-drive'
  'folgui/synology-hyper-backup-explorer'
  #folgui/synology-note-station
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING INTERNET/NETWORK PACKAGES"

msg_info "Installing internet and network packages"
sudo pacman --noconfirm --needed -S ${PKG_INTERNET[@]}

msg_info "Installing Synology packages"
sudo pacman --noconfirm --needed -S ${PKG_SYNOLOGY[@]}

msg_info "Disabling UFW firewall by default"
sudo ufw disable

print_done

exit 0
