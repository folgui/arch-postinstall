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

PKG_OFFICE=(
'aspell'
'aspell-en'
'aspell-es'
'calibre'
'hunspell'
'hunspell-en_US'
'hunspell-es_any'
'hunspell-es_es'
'libreoffice-fresh'
'libreoffice-fresh-es'
'folgui/libreoffice-extension-dictionaries-es'
'chaotic-aur/onlyoffice-bin'
'chaotic-aur/wps-office'
'chaotic-aur/wps-office-mime'
'chaotic-aur/wps-office-mui-es-es'
'chaotic-aur/ttf-wps-fonts'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING OFFICE PACKAGES"


msg_info "Installing internet and network packages"
sudo pacman --needed --noconfirm -S ${PKG_OFFICE[@]}

print_done

exit 0