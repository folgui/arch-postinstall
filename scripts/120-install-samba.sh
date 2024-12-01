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

PKG_SAMBA=(
'samba'
'avahi'
'kdenetwork-filesharing'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "SAMBA INSTALLATION AND CONFIGURATION"

msg_info "Installing packages ..."
sudo pacman -S --noconfirm --needed ${PKG_SAMBA[@]}
sudo pacman -S --noconfirm --needed samba
sudo pacman -S --noconfirm --needed avahi
sudo pacman -S --noconfirm --neded kdenetwork-filesharing
#sudo pacman -S --noconfirm --neded smb4k
#sudo pacman -S --noconfirm --needed gvfs-smb


if [[ ! -f /etc/samba/smb.conf ]]; then
  sudo wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf.original
  #sudo wget "https://raw.githubusercontent.com/arcolinux/arcolinux-system-config/master/etc/samba/smb.conf.arcolinux" -O /etc/samba/smb.conf.arcolinux
  #sudo wget "https://raw.githubusercontent.com/TechXero/ArcoLinux/main/Configs/smb.conf" -O /etc/samba/smb.conf
  sudo wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf
fi

msg_info "Enabling and starting SAMBA services"
# sudo systemctl enable smb.service
# sudo systemctl start smb.service
# sudo systemctl enable nmb.service
# sudo systemctl start nmb.service
# sudo systemctl enable avahi-daemon.service
# sudo systemctl start avahi-daemon.service
systemctl is-enabled --quiet smb.service || sudo systemctl enable smb.service
systemctl is-active --quiet smb.service || sudo systemctl start smb.service
systemctl is-enabled --quiet nmb.service || sudo systemctl enable nmb.service
systemctl is-active --quiet nmb.service || sudo systemctl start nmb.service
systemctl is-enabled --quiet avahi-daemon.service || sudo systemctl enable avahi-daemon.service
systemctl is-active --quiet avahi-daemon.service || sudo systemctl start avahi-daemon.service

read -p "* What is your login (username)? It will be used to add this user to smb : " user
sudo smbpasswd -a $user

#change nsswitch.conf for access to nas servers
#original line comes from the package filesystem
#hosts: files mymachines myhostname resolve [!UNAVAIL=return] dns
#ArcoLinux line
#hosts: files mymachines resolve [!UNAVAIL=return] mdns dns wins myhostname

# #first part
# sudo sed -i 's/files mymachines myhostname/files mymachines/g' /etc/nsswitch.conf
# #last part
# sudo sed -i 's/\[\!UNAVAIL=return\] dns/\[\!UNAVAIL=return\] mdns dns wins myhostname/g' /etc/nsswitch.conf

file=/etc/samba/smb.conf

if [[ -f $file ]]; then
    sudo sed -i '/^\[global\]/a \
    \
    usershare allow guests = true \
    usershare max shares =  100 \
    usershare owner only = no \
    usershare path = /var/lib/samba/usershares' $file
fi

sudo mkdir -p /var/lib/samba/usershares
sudo groupadd -r sambashare
sudo gpasswd -a $user sambashare
sudo chown root:sambashare /var/lib/samba/usershares
sudo chmod 1770 /var/lib/samba/usershares

msg_info "A reboot is recommended"

print_done

exit 0
