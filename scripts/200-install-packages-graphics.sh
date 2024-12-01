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

PKG_GRAPHICS=(
'digikam'
'gimp'
'gimp-help-es'
'gimp-plugin-gmic'
'gmic'
'icoutils'
'inkscape'
'kphotoalbum'
'libwebp'
'webp-pixbuf-loader'
'folgui/color-icc-srgb'
'folgui/gimp-plugin-bimp'
'folgui/gimp-plugin-duplicate-to-another-image'
'folgui/gimp-plugin-export-layers'
'folgui/gimp-plugin-instagram-effects'
'folgui/gimp-plugin-layer-via-copy-cut'
'folgui/gimp-plugin-reflection'
#folgui/gimp-plugin-saveforweb (incluido en gimp-plugin-registry)
'folgui/upscaler'
)

PKG_GRAPHICS_AUR=(
'gimp-plugin-registry'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING GRAPHIC PACKAGES"

msg_info "Installing graphic packages"
sudo pacman --noconfirm --needed -S ${PKG_GRAPHICS[@]}

print_done

exit 0

