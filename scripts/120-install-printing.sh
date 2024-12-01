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

PKG_CUPS=(
'cups'
'cups-filters'
'cups-pdf'
'cups-pk-helper'
'foomatic-db'
'foomatic-db-engine'
'foomatic-db-gutenprint-ppds'
'foomatic-db-nonfree'
'foomatic-db-nonfree-ppds'
'foomatic-db-ppds'
'ghostscript'
'gsfonts'
'gutenprint'
'hplip'
'lcms2'
'libcups'
'libcupsfilters'
'libppd'
'print-manager'
'system-config-printer'
'sane'
'simple-scan'
'skanlite'
'skanpage'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALL PRINT-SCAN PACKAGES AND SERVICES"

msg_info "Installing cups packages ..."
# sudo pacman -S --noconfirm --needed ${PKG_CUPS[@]}
# sudo pacman -S --noconfirm --needed cups
# sudo pacman -S --noconfirm --needed cups-filters
# sudo pacman -S --noconfirm --needed cups-pdf
# sudo pacman -S --noconfirm --needed cups-pk-helper
# sudo pacman -S --noconfirm --needed foomatic-db
# sudo pacman -S --noconfirm --needed foomatic-db-engine
# sudo pacman -S --noconfirm --needed foomatic-db-gutenprint-ppds
# sudo pacman -S --noconfirm --needed foomatic-db-nonfree
# sudo pacman -S --noconfirm --needed foomatic-db-nonfree-ppds
# sudo pacman -S --noconfirm --needed foomatic-db-ppds
# sudo pacman -S --noconfirm --needed ghostscript
# sudo pacman -S --noconfirm --needed gsfonts
# sudo pacman -S --noconfirm --needed gutenprint
# sudo pacman -S --noconfirm --needed hplip
# #sudo pacman -S --noconfirm --needed hplip-lite
# sudo pacman -S --noconfirm --needed lcms2
# sudo pacman -S --noconfirm --needed libcups
# sudo pacman -S --noconfirm --needed libcupsfilters
# sudo pacman -S --noconfirm --needed libppd
# sudo pacman -S --noconfirm --needed print-manager
# sudo pacman -S --noconfirm --needed system-config-printer
# sudo pacman -S --noconfirm --needed sane
# sudo pacman -S --noconfirm --needed simple-scan
# sudo pacman -S --noconfirm --needed skanlite
# sudo pacman -S --noconfirm --needed skanpage

msg_info "Starting CUPS service ..."
#sudo systemctl enable --now cups.service
systemctl is-enabled --quiet cups.service || sudo systemctl enable cups.service
systemctl is-active --quiet cups.service || sudo systemctl start cups.service

print_done

exit 0
