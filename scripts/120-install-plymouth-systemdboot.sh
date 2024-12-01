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

print_title "PLYMOUTH INSTALLATION FOR SYSTEMD-BOOT BOOTLOADER"

if [ ! -d /boot/loader/entries ] ; then
	msg_error "You do not seem to be on a systemd-boot system. Run the script for grub."
fi

msg_info "Installing plymouth and themes on a systemd-boot system ..."
sudo pacman -S --noconfirm --needed plymouth
sudo pacman -S --noconfirm --needed plymouth-theme-monoarch

msg_info "Setting up configuration ..."

if grep -q sd-plymouth /etc/mkinitcpio.conf; then
	msg_success "MKINITCPIO already configured for PLYMOUTH"
else
	FIND="HOOKS=(base systemd autodetect"
	REPLACE="HOOKS=(base systemd sd-plymouth autodetect"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/mkinitcpio.conf
fi

if grep -q splash /boot/loader/entries/arch-linux.conf; then
	msg_success "SYSTEMD-BOOT already configured for PLYMOUTH"
else
	FIND="options initrd=initramfs-linux.img"
	REPLACE="options initrd=initramfs-linux.img quiet splash vt.global_cursor_default=0"
	sudo sed -i "s/$FIND/$REPLACE/g" /boot/loader/entries/arch-linux.conf
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

print_done

exit 0
