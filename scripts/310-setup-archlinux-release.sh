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

# Sustituir archivos "release" de otras distros por ArchLinux

clear

print_title "ARCHLINUX DISTRO RELEASE FILES RESTORE"

#cd "$WORK_DIR/scripts"

msg_info "Creating backups"
[[ -f /etc/issue ]] && sudo cp /etc/issue /etc/issue.$DATE_NOW.bak
[[ -f /etc/lsb-release ]] && sudo cp /etc/lsb-release /etc/lsb-release.$DATE_NOW.bak
[[ -f /etc/os-release ]] && sudo cp /etc/os-release /etc/os-release.$DATE_NOW.bak

msg_info "Restoring with Archlinux files"
sudo cp "$WORK_DIR"/settings/release/* /etc/
print_done

# exit the right way
exit 0

