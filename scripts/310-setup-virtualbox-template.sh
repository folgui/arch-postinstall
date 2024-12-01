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

# WORK_DIR=$(cd "$(dirname "$0")" && pwd)
# WORK_DIR comes from BASHHELPER > common.sh
source ./BashHelper/config.sh
source ./BashHelper/common.sh

#VBOXDIR=$HOME"/VirtualBox VMs"
VBOXDIR="/run/media/DATA/VirtualMachines/vbox"

print_title "COPY VIRTUALBOX TEMPLATE"

if [[ -d $VBOXDIR ]]; then
	msg_info "Copying and extracting template"
	cp -rf "$WORK_DIR/settings/virtualbox-template/template.tar.gz" "$VBOXDIR"
	cd "$VBOXDIR"
	tar -xzf template.tar.gz
	rm -f template.tar.gz
else
	msg_warning "VirtualBox Machines folder does not exist: $VBOXDIR"
fi
