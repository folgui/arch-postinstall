#!/bin/bash

PKG_CURSORS=(
'capitaine-cursors'
'xcursor-bluecurve'
'xcursor-premium'
'chaotic-aur/vimix-cursors'
'chaotic-aur/whitesur-cursor-theme-git'
'folgui/breeze-blue-cursor-theme'
'folgui/volantes-cursors'
'folgui/xcursor-arch-cursor-complete'
'folgui/xcursor-azenis-blue'
'folgui/xcursor-mayaserie-orange'
'folgui/xcursor-mayaserie-blue'
'folgui/xcursor-mayaserie-white'
)

PKG_FONTS=(
'adobe-source-code-pro-fonts'
'awesome-terminal-fonts'
'cantarell-fonts'
'fontconfig'
'freetype2'
'noto-fonts'
'gentium-plus-font'
'gnome-font-viewer'
'gnu-free-fonts'
'gsfonts'
'inter-font'
'otf-fantasque-sans-mono'
'otf-fira-mono'
'otf-font-awesome'
'powerline-fonts'
'terminus-font'
'ttf-bitstream-vera'
'ttf-cascadia-code'
'ttf-croscore'
'ttf-dejavu'
'ttf-fantasque-sans-mono'
'ttf-fira-code'
'ttf-fira-mono'
'ttf-font-awesome'
'ttf-freefont'
'ttf-hack'
'ttf-ibm-plex'
'ttf-jetbrains-mono'
'ttf-jetbrains-mono-nerd'
'ttf-liberation'
'ttf-linux-libertine'
'ttf-monoid'
'ttf-monoid-nerd'
'ttf-opensans'
'ttf-terminus-nerd'
'terminus-font'
'ttf-ubuntu-font-family'
'ttf-ubuntu-mono-nerd'
'chaotic-aur/otf-font-awesome-4'
'chaotic-aur/otf-raleway'
'chaotic-aur/ttf-mac-fonts'
'chaotic-aur/ttf-meslo-nerd-font-powerlevel10k'
'chaotic-aur/ttf-ms-fonts'
'chaotic-aur/ttf-raleway'
'arcolinux_repo_3party/font-manager-git'
'folgui/nerd-fonts-complete'
'folgui/folgui/otf-san-francisco'
'folgui/ttf-tahoma'
'folgui/ttf-vista-fonts'
'folgui/ttf-windows'
)

PKG_FONTS_AUR=(
'otf-san-francisco-mono'
)

PKG_ICONS=(
'arc-icon-theme'
'breeze-icons'
'deepin-icon-theme'
'papirus-icon-theme'
'chaotic-aur/flat-remix'
'chaotic-aur/paper-icon-theme-git'
'chaotic-aur/papirus-folders-gui'
'chaotic-aur/papirus-libreoffice-theme'
'chaotic-aur/surfn-icons-git'
'arcolinux_repo_3party/halo-icons-git'
'folgui/antu-icon-theme-git'
'folgui/breeze-extra'
'folgui/papirus-folders'
)

PKG_THEMES=(
'arc-gtk-theme'
'arc-kde'
'folgui/breeze-enhanced-git'
'breeze-gtk'
'cutefish-qt-plugins'
#deepin-gtk-theme
#gtk-theme-paper
'kde-gtk-config'
'kvantum-qt5'
'chaotic-aur/lightly-qt'
#'numix-gtk-theme'
#'numix-frost-themes'
'folgui/plasma5-theme-aex-nomad-dark-git'
'folgui/plasma5-theme-aex-nomad-git'
'folgui/plasma5-theme-breeze-transparent-nomad-icons-git'
'folgui/plasma5-theme-breeze-noshadow-antu-git'
#'chaotic-aur/qogir-kde-theme-git'
#'chaotic-aur/qogir-icon-theme-git'
#'chaotic-aur/kvantum-theme-qogir-git'
'chaotic-aur/sddm-config-editor-git'
)

echo
tput setaf 3
echo "############################################################"
echo "### Intalling UI packages: Themes, icons, cursors, fonts ###"
echo "############################################################"
tput sgr0
echo

sudo pacman --noconfirm --needed -S ${PKG_CURSORS[@]}
sudo pacman --noconfirm --needed -S ${PKG_FONTS[@]}
sudo pacman --noconfirm --needed -S ${PKG_ICONS[@]}

echo
tput setaf 6
echo "################################################################"
echo "################### Done"
echo "################################################################"
tput sgr0
echo
