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


# https://wiki.archlinux.org/title/Plymouth

print_title "PLYMOUTH INSTALLATION FOR GRUB BOOTLOADER"

if [ -d /boot/loader/entries ] ; then
	msg_error "You seem to be on a systemd-boot enabled system. Run the script for systemd-boot."
fi

msg_info "Installing plymouth and themes on a grub system ..."
sudo pacman -S --noconfirm --needed plymouth
sudo pacman -S --noconfirm --needed plymouth-theme-monoarch

msg_info "Setting up configuration ..."

if grep -q plymouth /etc/mkinitcpio.conf; then
	msg_success "MKINITCPIO already configured for PLYMOUTH"
else
	FIND="base udev autodetect"
	REPLACE="base udev plymouth autodetect"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/mkinitcpio.conf
fi

if grep -q splash /etc/default/grub; then
	msg_sucess "GRUB already configured for PLYMOUTH"
else
	FIND="GRUB_CMDLINE_LINUX_DEFAULT=\"quiet loglevel=3"
	REPLACE="GRUB_CMDLINE_LINUX_DEFAULT=\"quiet loglevel=3 splash"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/default/grub
fi

msg_info "Setting plymouth theme ..."
sudo plymouth-set-default-theme -R monoarch

msg_info "Updating GRUB ..."
sudo grub-mkconfig -o /boot/grub/grub.cfg

print_done

exit 0
