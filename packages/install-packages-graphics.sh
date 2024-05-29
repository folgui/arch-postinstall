#!/bin/bash

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

echo
tput setaf 3
echo "###################################"
echo "### Installing GRAPHIC packages ###"
echo "###################################"
tput sgr0
echo

sudo pacman --noconfirm --needed -S ${PKG_GRAPHICS[@]}

echo
tput setaf 6
echo "############"
echo "### DONE ###"
echo "############"
tput sgr0
echo

