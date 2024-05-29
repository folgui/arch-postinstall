#!/bin/bash

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
'tor-browser'
'traceroute'
'wireshark-qt'
)

PKG_SYNOLOGY=(
'folgui/synology-assistant'
'folgui/synology-drive'
'folgui/synology-hyper-backup-explorer'
#folgui/synology-note-station
)

echo
tput setaf 3
echo "#########################################################"
echo "################### Installing INTERNET/NETWORK Tools ###"
echo "#########################################################"
tput sgr0
echo

sudo pacman --noconfirm --needed -S ${PKG_INTERNET[@]}
sudo pacman --noconfirm --needed -S ${PKG_SYNOLOGY[@]}

echo
tput setaf 6
echo "############"
echo "### DONE ###"
echo "############"
tput sgr0
echo
