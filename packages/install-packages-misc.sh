#!/bin/bash

PKG_MISC=(
'arch-wiki-docs'
'arch-wiki-lite'
#drawio-desktop-bin
#google-earth-pro
'folgui/tellico'
)


echo
tput setaf 3
echo "########################################"
echo "### Intalling MISCELLANEOUS packages ###"
echo "########################################"
tput sgr0
echo

sudo pacman --needed --noconfirm -S ${PKG_MISC[@]}

echo
tput setaf 6
echo "############"
echo "### DONE ###"
echo "############"
tput sgr0
echo

