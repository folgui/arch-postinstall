#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-

#DEBUG
#set -x ## Use “set -x” to enable debug mode
#set -e ## Use "set -e" to exit on error
set -u ## Use "set -u" alway to make sure you won't use any undeclared variable. This saves you from a lot of headaches and critical bugs.

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

PKG_WAYLAND=(
  'wayland'
  'xorg-xwayland'
  'xorg-xlsclients'
  'qt5-wayland'
  'qt6-wayland'
  'glfw-wayland'
  'xwaylandvideobridge'
)

PKG_PLASMA=(
  'plasma-desktop'
  'plasma-wayland-session'
  'ark'
  'dolphin'
  'dolphin-plugins'
  'falkon'
  'ffmpegthumbs'
  'gwenview'
  'haruna'
  'kate'
  'kcalc'
  'kcmutils'
  'kde-gtk-config'
  'kdenetwork-filesharing'
  'kio'
  'kio-admin'
  'kio-extras'
  'kio-fuse'
  'kmix'
  'konsole'
  'krename'
  'kscreen'
  'okular'
  'partitionmanager'
  'spectacle'
  'sddm'
  'sddm-kcm'
  'xdg-desktop-portal'
  'xdg-desktop-portal-kde'
  'xdg-user-dirs'
)

PKG_ADDITIONAL=(
  '#ntfs-3g'
  '#gvfs-mtp'
  'chaotic-aur/ntfsprogs-ntfs3'
  'android-udev'
  'mtpfs'
  '#kio-fuse'
  '#kio-extras'
)
# NOTES:
# Package 'qt5ct' conflicts with plasma-integration and breaks the look and feel of Qt software when run on Plasma.
# Package 'xdg-desktop-portal-gnome' conflicts with xdg-desktop-portal-kde and breaks various things.

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "REMOVE/INSTALL KDE PLASMA PACKAGES"

if [ -f /usr/share/wayland-sessions/plasma.desktop ]; then
  msg_info "Removing KDE PLASMA not required packages"
  sudo pacman -Rns --noconfirm ${PKG_PLASMA_REMOVE[@]}

  msg_info "Installing WAYLAND neccesary packages"
  sudo pacman --noconfirm --needed -S ${PKG_WAYLAND[@]}

  msg_info "Installing KDE PLASMA packages"
  sudo pacman --noconfirm --needed -S ${PKG_PLASMA[@]}

  msg_info "Installing KDE PLASMA additional packages"
  sudo pacman --noconfirm --needed -S ${PKG_ADDITIONAL[@]}

  msg_info "Enabling SDDM login manager"
  sudo systemctl enable sddm
  #sudo systemctl start sddm

  msg_info "Appying plasma settings and personal configuration"
  #   sudo wget https://raw.githubusercontent.com/erikdubois/arcolinux-nemesis/master/Personal/settings/variety/variety.conf -O ~/.config/variety/variety.conf
  #
  #   sudo pacman -S --noconfirm --needed arcolinux-plasma-keybindings-git
  #
  #   cp /etc/skel/.config/kglobalshortcutsrc ~/.config/
  #   cp /etc/skel/.config/kglobalshortcutsrc-or ~/.config/
  #
  #   sudo pacman -S --noconfirm --needed arcolinux-plasma-servicemenus-git
  #
  #   if [ ! -d ~/.local/share/kio/servicemenus/ ]; then
  #     mkdir -p ~/.local/share/kio/servicemenus/
  #   fi
  #
  #   cp -v /etc/skel/.local/share/kio/servicemenus/* ~/.local/share/kio/servicemenus/
  #
  #   echo "Overwriting plasma settings here!"
  #   cp -rv $HOME/DATA/arcolinux-nemesis/Personal/settings/plasma6/.* ~
  #
  #   if ! grep -q "wobblywindowsEnabled=true" $HOME/.config/kwinrc; then
  #   echo '
  #
  # [Plugins]
  # wobblywindowsEnabled=true' | sudo tee -a ~/.config/kwinrc
  #   fi

  # Enable Global Menu: For some apps like Visual Studio Code, the global menu may not work or may be attached to the parent app instead of the panel.
  # To enable global menu support, run the command and restart the app.
  sudo pacman -S appmenu-gtk-module libdbusmenu-glib

  print_done
else
  msg_warning "You are not in KDE PLASMA 6 (WAYLAND)"
fi

exit 0
