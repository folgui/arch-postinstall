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

PKG_WAYLAND=(
'wayland'
'xorg-xwayland'
'xorg-xlsclients'
'qt5-wayland'
'qt6-wayland'
'glfw-wayland'
'xwaylandvideobridge'
)

PKG_PLASMA_REMOVE=(
'kde-accessibility'
'kde-accessibility-meta'
'kde-education'
'kde-education-meta'
'kde-games'
'kde-games-meta'
'kde-pim'
'kde-pim-meta'
'angelfish'
'cervisia'
'k3b'
'kfloppy'
'kimageformats5'
'qt5-imageformats'
'kmix'
'kongress'
'konversation'
'kopete'
'kteatime'
'ktimer'
'ktorrent'
'ktrip'
'neochat'
'phonon-qt5'
'phonon-qt5-gstreamer'
'phonon-qt5-vlc'
'telly-skout'
'umbrello'
)

PKG_PLASMA=(
'plasma'
'#plasma-meta'
'plasma-wayland-session'
'plasma-workspace'
'plasma-workspace-wallpapers'
'sddm'
'sddm-kcm'
'#kde-applications'
'#kde-applications-meta'
'kde-graphics'
'#kde-graphics-meta'
'kde-multimedia'
'#kde-multimedia-meta'
'kde-network'
'#kde-network-meta'
'kde-office'
'#kde-office-meta'
'#kde-pim'
'#kde-pim-meta'
'kde-system'
'#kde-system-meta'
'kde-utilities'
'#kde-utilities-meta'
'kdevelop'
'#kdevelop-meta'
'kdesdk'
'#kde-sdk-meta'
'kf5'
'kf5-aids'
'nerd-fonts'
'pyqt5'
'pyqt6'
'qt'
'qt5'
'qt5-wayland'
'qt6'
'qt6-wayland'
'telepathy'
'telepathy-kde'
'ark'
'appstream'
'appstream-qt'
'archlinux-appstream-data'
'baloo-widgets'
'bluedevil'
'breeze'
'breeze-grub'
'breeze-gtk'
'breeze-icons'
'bup'
'digikam'
'discover'
'dolphin'
'dolphin-plugins'
'falkon'
'ffmpegthumbs'
'filelight'
'flatpak-kcm'
'chaotic-aur/flatseal'
'fuse2'
'gwenview'
'haruna'
'kaccounts-integration'
'kaccounts-providers'
'#kalendar'
'kamoso'
'kate'
'kbackup'
'kcalc'
'kcharselect'
'#chaotic-aur/fancontrol-gui'
'#chaotic-aur/fancontrol-kcm'
'chaotic-aur/kcm-grub2-git'
'chaotic-aur/kcm-polkit-kde-git'
'chaotic-aur/kcm-uefi'
'kcmutils'
'kcolorchooser'
'kcron'
'kdeconnect'
'kdenlive'
'kde-gtk-config'
'kdegraphics-thumbnailers'
'kdenetwork-filesharing'
'kdesdk-thumbnailers'
'kdialog'
'kdiff3'
'kimageformats'
'qt6-imageformats'
'kinfocenter'
'kinit'
'kio'
'kio-admin'
'kio-extras'
'kio-fuse'
'kio-gdrive'
'kio-zeroconf'
'chaotic-aur/klassy-git'
'kolourpaint'
'arcolinux_repo_3party/konsave'
'konsole'
'kontrast'
'#kphotoalbum'
'kpipewire'
'krename'
'kscreen'
'kup'
'kvantum'
'chaotic-aur/kwin-effect-rounded-corners-git'
'chaotic-aur/kwin-effects-burn-my-windows-git'
'chaotic-aur/kwin-effects-kinetic'
'chaotic-aur/kwin-effects-sliding-notifications'
'chaotic-aur/kwin-effects-yet-another-magic-lamp'
'#latte-dock'
'chaotic-aur/lightly-kf6-git'
'folgui/lightlyshaders-plasma6-git'
'okular'
'packagekit'
'packagekit-qt6'
'pacmanlogviewer'
'partitionmanager'
'phonon-qt6'
'phonon-qt6-vlc'
'chaotic-aur/plasma5-applets-plasma-pstate'
'plasma-browser-integration'
'plasma-disks'
'plasma-nm'
'plasma-pa'
'plasma-wayland-protocols'
'plasma-welcome'
'print-manager'
'chaotic-aur/qdirstat'
'qjournalctl'
'folgui/qservicemenuconfig'
'qt5-gamepad'
'qt5-sensors'
'chaotic-aur/sddm-config-editor-git'
'#smb4k'
'spectacle'
'subtitlecomposer'
'chaotic-aur/systemd-kcm'
'telepathy-kde'
'#telepathy-kde-meta'
'telepathy-morse'
'yakuake'
'xdg-desktop-portal'
'xdg-desktop-portal-kde'
'xdg-user-dirs'
)

# NOTES:
# Package 'qt5ct' conflicts with plasma-integration and breaks the look and feel of Qt software when run on Plasma.
# Package 'xdg-desktop-portal-gnome' conflicts with xdg-desktop-portal-kde and breaks various things.

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

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


