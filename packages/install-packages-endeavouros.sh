#!/bin/bash
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

PKG_ENDEAVOUROS=(
'endeavouros/akm'
#endeavouros/eos-hooks
'endeavouros/eos-log-tool'
'endeavouros/eos-rankmirrors'
'endeavouros/keyserver-rank'
'endeavouros/reflector-simple'
)

echo
tput setaf 4
echo "##############################~##"
echo " Installing ENDEAVOUROS packages "
echo "#############################~###"
tput sgr0
echo

sudo pacman --noconfirm --needed -S ${PKG_ENDEAVOUROS[@]}

echo
tput setaf 2
echo ">>> DONE! <<<"
tput sgr0
echo
