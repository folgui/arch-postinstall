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

print_title "Modifying pacman.conf with custom settings"

msg_info "Creating backup of /etc/pacman.conf ..."
sudo cp /etc/pacman.conf /etc/pacman.conf.$DATE_NOW.bak

msg_info "Applying custom settings ..."

FIND="#Color"
REPLACE="Color"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

FIND="#CheckSpace"
REPLACE="CheckSpace"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

FIND="#VerbosePkgLists"
#REPLACE="VerbosePkgLists"
# Add ILoveCandy
REPLACE="VerbosePkgLists\\nILoveCandy"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

FIND="ParallelDownloads = 5"
REPLACE="ParallelDownloads = 20"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

print_done

exit 0

