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

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING CORE PACKAGES"

msg_info "Updating system repositories"
sudo pacman -Syy

msg_info "Installing core packages"
sudo pacman -S --noconfirm --needed aic94xx-firmware
sudo pacman -S --noconfirm --needed archiso
sudo pacman -S --noconfirm --needed avahi
sudo pacman -S --noconfirm --needed bash-completion
sudo pacman -S --noconfirm --needed bat
sudo pacman -S --noconfirm --needed btop
sudo pacman -S --noconfirm --needed curl
sudo pacman -S --noconfirm --needed downgrade
sudo pacman -S --noconfirm --needed duf
sudo pacman -S --noconfirm --needed expac
sudo pacman -S --noconfirm --needed fastfetch
sudo pacman -S --noconfirm --needed git
sudo pacman -S --noconfirm --needed gparted
sudo pacman -S --noconfirm --needed hardcode-fixer-git
sudo pacman -S --noconfirm --needed hardinfo2
sudo pacman -S --noconfirm --needed hddtemp
sudo pacman -S --noconfirm --needed linux-firmware-qlogic
sudo pacman -S --noconfirm --needed lshw
sudo pacman -S --noconfirm --needed man-db
sudo pacman -S --noconfirm --needed man-pages
sudo pacman -S --noconfirm --needed meld
sudo pacman -S --noconfirm --needed mkinitcpio-firmware
sudo pacman -S --noconfirm --needed paru
sudo pacman -S --noconfirm --needed plocate
sudo pacman -S --noconfirm --needed pv
sudo pacman -S --noconfirm --needed rate-mirrors
sudo pacman -S --noconfirm --needed ripgrep
sudo pacman -S --noconfirm --needed rsync
sudo pacman -S --noconfirm --needed squashfs-tools
sudo pacman -S --noconfirm --needed upd72020x-fw
sudo pacman -S --noconfirm --needed wd719x-firmware
sudo pacman -S --noconfirm --needed wget
sudo pacman -S --noconfirm --needed xdg-user-dirs
#sudo pacman -S --noconfirm --needed zsh
#sudo pacman -S --noconfirm --needed zsh-completions
#sudo pacman -S --noconfirm --needed zsh-syntax-highlighting

# if [ ! -f /usr/share/wayland-sessions/plasma.desktop ]; then
#   msg_info "WAYLAND PLASMA SESSION"
# fi
# if [ ! -f /usr/share/xsessions/plasmax11.desktop ]; then
#   msg_info "X11 PLASMA SESSION"
# fi

print_done

exit 0
