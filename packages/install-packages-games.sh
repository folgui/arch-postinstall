#!/bin/bash

PKG_STEAM=(
'steam'
#steam-native-runtime
'amdvlk'
'lib32-amdvlk'
'chaotic-aur/proton-ge-custom'
#ttf-ms-fonts
'ttf-liberation'
'vulkan-tools'
)

PKG_WINE=(
'chaotic-aur/bottles'
'playonlinux'
#'#wine'
'wine-staging'
'wine_gecko'
'wine-mono'
'winetricks'
)

PKG_GAMES=(
#'#assaultcube-reloaded'
'dolphin-emu'
'gamehub'
'gamemode'
'lutris'
'mame'
'mame-tools'
'retroarch'
'#retroarch-assets-xmb'
'#retroarch-assets-ozone'
'qmc2'
'supertuxkart'
'xonotic'
'chaotic-aur/heroic-games-launcher-bin'
'chaotic-aur/proton-caller'
'chaotic-aur/proton-ge-custom-bin'
#'chaotic-aur/q4wine'
'chaotic-aur/rpcs3-git'
'chaotic-aur/ryujinx-git'
'chaotic-aur/wine-installer'
'chaotic-aur/yuzu-mainline-bin'
'folgui/clrmamepro'
'folgui/libsciter-gtk-bin'
'folgui/gorom'
'folgui/portproton'
'folgui/ps3netsrv'
'folgui/rom-properties'
#'folgui/rpcs3-bin'
'folgui/steamcmd'
)

echo
tput setaf 3
echo "#################################"
echo "### Intalling GAMING packages ###"
echo "#################################"
tput sgr0
echo

sudo pacman --needed --noconfirm -S ${PKG_STEAM[@]}
sudo pacman --needed --noconfirm -S ${PKG_WINE[@]}
sudo pacman --needed --noconfirm -S ${PKG_GAMES[@]}

echo
tput setaf 6
echo "################################################################"
echo "################### Done"
echo "################################################################"
tput sgr0
echo

