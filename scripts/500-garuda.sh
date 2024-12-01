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

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

print_title "GARUDA CLEANUP SCRIPT"

if grep -q "Garuda" /etc/os-release; then

	if [ -f /etc/environment ]; then
		echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee /etc/environment
		echo "QT_STYLE_OVERRIDE=kvantum" | sudo tee -a /etc/environment
		echo "EDITOR=nano" | sudo tee -a /etc/environment
		echo "BROWSER=firefox" | sudo tee -a /etc/environment
	fi

	FIND="Arc-Dark"
	REPLACE="Arc-Dawn-Dark"
	sed -i "s/$FIND/$REPLACE/g" ~/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
fi

print_done

# exit the right way
exit 0

