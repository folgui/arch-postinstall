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

# ORDER OF SCRIPTS:
# 0xx > start and needed stuff, remove unneeded, system configs
# 1xx > core apps and services
# 2xx > installation of apps by category
# 3xx > personal config and settings
# 5xx > custom distro cleanups

# WORK_DIR=$(cd "$(dirname "$0")" && pwd)
# WORK_DIR comes from BASHHELPER > common.sh
source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "START OF ARCHLINUX POSTINSTALL SCRIPT (APIT)"

msg_info "Upgrading repositories"
sudo pacman -Syy

cd "$WORK_DIR/scripts"

exit 0

msg_info "Adding repositories"
sh 01*

msg_info "Removing packages"
sh 020-remove-packages*

msg_info "Applying system settings"
sh 030-setup*

msg_info "Installing core apps and services"
sh 100-install*
sh 105-install*
sh 110-install*
sh 120-install*

msg_info "Installing KDE PLASMA packages"
sh 130-install*

msg_info "Installing software packages"
sh 200-install*

msg_info "Applying personal settings"
sh 300-*
sh 310-*

msg_info "Cleaning distro bloatware"
sh 500-*

cd "$WORK_DIR"

print_done

# exit the right way
exit 0
