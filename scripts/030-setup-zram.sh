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

print_title "INSTALL AND SETUP OF ZRAM"

msg_info "More info at: https://github.com/systemd/zram-generator"
blank_line
blank_line

sudo pacman -S --noconfirm --needed zram-generator

blank_line
msg_info "Creating /etc/systemd/zram-generator.conf file ..."

# We setup 2 swap devices of max 8GB (64/8) each one, better than 1 16GB because if system doesnt need zram1, it's size if free.
echo '[zram0]
zram-size = min(ram / 8, 4096)
compression-algorithm = zstd
[zram1]
zram-size = min(ram / 8, 4096)
compression-algorithm = zstd' | tee /etc/systemd/zram-generator.conf > /dev/null

msg_info "Enabling ZRAM ..."
sudo systemctl daemon-reload
sudo systemctl start /dev/zram0
sudo systemctl start /dev/zram1

msg_success "Check ZRAM status with 'swapon' or 'zramctl' or 'systemctl status systemd-zram-setup@zram0.service'"

print_done

# exit the right way
exit 0
