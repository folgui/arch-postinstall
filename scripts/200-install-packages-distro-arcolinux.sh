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

PKG_ARCOLINUX=(
'arcolinux-app-glade-git'
'archlinux-tweak-tool-git'
'sofirem-git'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING ARCOLINUX PACKAGES"

if grep -q arcolinux_repo /etc/pacman.conf; then
  msg_info "Installing arcolinux packages"
  sudo pacman --noconfirm --needed -S ${PKG_ARCOLINUX[@]}
else
  msg_failed "ARCOLINUX repository is not in pacman.conf. You must add it."
fi

print_done

exit 0
