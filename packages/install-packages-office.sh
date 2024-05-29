#!/bin/bash

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


echo
tput setaf 3
echo "#################################"
echo "### Intalling OFFICE packages ###"
echo "#################################"
tput sgr0
echo

sudo pacman --needed --noconfirm -S ${PKG_OFFICE[@]}

echo
tput setaf 6
echo "############"
echo "### DONE ###"
echo "############"
tput sgr0
echo

