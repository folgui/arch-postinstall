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

print_title "SDDM DISPLAY MANAGER CONFIGURATION"

if [[ -d /etc/sddm.conf.d ]]; then
	if [[ -f /etc/sddm.conf.d/kde_settings.conf ]]; then
		if grep -q Theme /etc/sddm.conf.d/kde_settings.conf; then
			msg_info "Changing theme of SDDM"
			sudo pacman -S --noconfirm --needed arcolinux-sddm-simplicity-git
			FIND="Current=breeze"
			REPLACE="Current=arcolinux-simplicity"
			sudo sed -i "s/$FIND/$REPLACE/g" /etc/sddm.conf.d/kde_settings.conf
		fi

		if grep -q Autologin /etc/sddm.conf.d/kde_settings.conf
			msg_info "Enabling SDDM autologin"
			FIND="#User="
			REPLACE="User=folgui"
			sudo sed -i "s/$FIND/$REPLACE/g" /etc/sddm.conf.d/kde_settings.conf
		fi
	fi
fi

print_done

exit 0
