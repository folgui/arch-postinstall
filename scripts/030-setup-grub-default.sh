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

print_title "Modifying /etc/default/grub with custom settings"


msg_info "Creating backup of /etc/default/grub ..."
sudo cp /etc/default/grub /etc/default/grub.$DATE_NOW.bak

msg_info "Applying custom settings ..."

# If installation with EZArcher, change to Archlinux
if grep -q ezarcher /etc/default/grub; then
    sudo sed -i "s/^GRUB_DISTRIBUTOR='ezarcher'/GRUB_DISTRIBUTOR='Arch'/g" /etc/default/grub
fi

# Add splash
if grep -q "splash"; then
    # Nothing
else
    sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT='quiet loglevel=3'/GRUB_CMDLINE_LINUX_DEFAULT='quiet loglevel=3 splash'/g" /etc/default/grub
fi

# Add amdgpu stuff
amdstring=$(printf 'amdgpu.ppfeaturemask=0x%x\n' "$(($(cat /sys/module/amdgpu/parameters/ppfeaturemask) | 0x4000))")
# Output: amdgpu.ppfeaturemask=0xfff7ffff
if grep -q "$amdstring"; then
    # Nothing
else
    sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT='quiet loglevel=3 splash'/GRUB_CMDLINE_LINUX_DEFAULT='quiet loglevel=3 splash amdgpu.ppfeaturemask=0xfff7ffff'/g" /etc/default/grub
fi

# Disable submenus in grub
sudo sed -i "s/^#GRUB_DISABLE_SUBMENU=y/GRUB_DISABLE_SUBMENU=y/g" /etc/default/grub

# Add custom config for themes, fonts, etc.
if grep -q "### FOLGUI ###"; then
    # Nothing
else
sudo cat << EOF >> /etc/default/grub

### FOLGUI ###
#GRUB_DEFAULT=saved
#GRUB_SAVEDEFAULT="true"
#GRUB_DISABLE_SUBMENU=y
GRUB_FONT=/boot/grub/fonts/DejaVuSansMono.pf2
#GRUB_BACKGROUND=/boot/grub/background.jpg
#GRUB_COLOR_NORMAL="light-blue/black"
#GRUB_COLOR_HIGHLIGHT="light-cyan/blue"

#El siguiente tiene la fuente muy pequeña
#GRUB_THEME="/usr/share/grub/themes/bigsur/theme.txt"
#GRUB_THEME="/usr/share/grub/themes/breeze/theme.txt"
#GRUB_THEME="/usr/share/grub/themes/starfield/theme.txt"
#GRUB_THEME="/usr/share/grub/themes/whitesur-color-4k/theme.txt"
#GRUB_THEME="/usr/share/grub/themes/whitesur-white-4k/theme.txt"
#GRUB_THEME="/home/folgui/.local/share/grub/themes/bigsurmod/theme.txt"
#GRUB_THEME="/home/folgui/.local/share/grub/themes/folgui-v2/theme.txt"
#GRUB_THEME="/boot/grub/themes/folgui-v2/theme.txt"
GRUB_THEME="/boot/grub/themes/arch-linux/theme.txt"
EOF
fi

msg_info "Updating GRUB ..."
sudo grub-mkconfig -o /boot/grub/grub.cfg

print_done

exit 0

