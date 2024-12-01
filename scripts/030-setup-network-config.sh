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

clear

# To set DNS servers for all connections, specify them in NetworkManager.conf(5) using the syntax
# servers=serveripaddress1,serveripaddress2,serveripaddress3 in a section named [global-dns-domain-*]
# in /etc/NetworkManager/conf.d/dns-servers.conf

print_title "NETWORKMANAGER CUSTOM GLOBAL DNS SERVERS"

#cd "$WORK_DIR/scripts"

msg_info "Creating backups"
[[ -f /etc/NetworkManager/conf.d/dns-servers.conf ]] && sudo cp /etc/NetworkManager/conf.d/dns-servers.conf /etc/NetworkManager/conf.d/dns-servers.conf.$DATE_NOW.bak

msg_info "Setting custom global DNS Servers for NetworkManager"
sudo cp "$WORK_DIR"/settings/config-etc/dns-servers.conf /etc/NetworkManager/conf.d/
sudo sysctl -p
print_done

# exit the right way
exit 0

