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
'glfw-wayland'
)


script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "APPLYING PERSONAL SETTINGS"

msg_info "Checking and creating folders"

[[ -d $HOME"/personal/.config" ]] || sudo mkdir -p $HOME"/personal/.config"

[[ -d $HOME"/bin" ]] || mkdir -p $HOME"/bin"
[[ -d $HOME"/.bin" ]] || mkdir -p $HOME"/.bin"
[[ -d $HOME"/.fonts" ]] || mkdir -p $HOME"/.fonts"
[[ -d $HOME"/.icons" ]] || mkdir -p $HOME"/.icons"
[[ -d $HOME"/.themes" ]] || mkdir -p $HOME"/.themes"
[[ -d $HOME"/.local/bin" ]] || mkdir -p $HOME"/.local/bin"
[[ -d $HOME"/.local/share/icons" ]] || mkdir -p $HOME"/.local/share/icons"
[[ -d $HOME"/.local/share/themes" ]] || mkdir -p $HOME"/.local/share/themes"
[[ -d $HOME"/.config" ]] || mkdir -p $HOME"/.config"
[[ -d $HOME"/.config/gtk-3.0" ]] || mkdir -p $HOME"/.config/gtk-3.0"
[[ -d $HOME"/.config/gtk-4.0" ]] || mkdir -p $HOME"/.config/gtk-4.0"
[[ -d $HOME"/.config/variety" ]] || mkdir -p $HOME"/.config/variety"
[[ -d $HOME"/.config/neofetch" ]] || mkdir -p $HOME"/.config/neofetch"
[[ -d $HOME"/.config/fastfetch" ]] || mkdir -p $HOME"/.config/fastfetch"
[[ -d $HOME"/Proyectos" ]] || mkdir -p $HOME"/Proyectos"

msg_info "Copying all files and folders from ~/personal/.config to ~/.config"
msg_info "First we make a backup of .config. Wait for it"

cp -Rf ~/.config ~/.config-backup-$(date +%Y-%m-%d_%H.%M.%S).bak
cp -arf ~/personal/.config ~/.config

#cp -Rv $HOME"/personal/.config/variety" $HOME"/.config/variety"
#cp $installed_dir/settings/variety/variety.conf $HOME"/.config/variety"

# DOTFILES
msg_info "Restoring dotfiles from github repository"
user=$(whoami)
git clone https://github.com/folgui/dotfiles.git
cd dotfiles
rm LICENSE
rm README.md
cp -R * /home/$user
cd ..
rm -fr dotfiles


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

# echo
# echo "Sublime text settings"
# echo
# [ -d $HOME"/.config/sublime-text/Packages/User" ] || mkdir -p $HOME"/.config/sublime-text/Packages/User"
# cp  $installed_dir/settings/sublimetext/Preferences.sublime-settings $HOME/.config/sublime-text/Packages/User/Preferences.sublime-settings
# echo


# echo
# echo "VirtualBox check - copy/paste template or not"
# echo
#
# result=$(systemd-detect-virt)
# if [ $result = "none" ];then
#
# 	echo
# 	tput setaf 2
# 	echo "################################################################"
# 	echo "####### Copy paste virtual box template"
# 	echo "################################################################"
# 	tput sgr0
# 	echo
#
# 	[ -d $HOME"/VirtualBox VMs" ] || mkdir -p $HOME"/VirtualBox VMs"
# 	sudo cp -rf settings/virtualbox-template/* ~/VirtualBox\ VMs/
# 	cd ~/VirtualBox\ VMs/
# 	tar -xzf template.tar.gz
# 	rm -f template.tar.gz
#
# else
#
# 	echo
# 	tput setaf 3
# 	echo "################################################################"
# 	echo "### You are on a virtual machine - skipping VirtualBox"
# 	echo "### Template not copied over"
# 	echo "### We will set your screen resolution with xrandr"
# 	echo "################################################################"
# 	tput sgr0
# 	echo
#
# 	xrandr --output Virtual-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
#
# fi

# 	echo "Installing all shell files"
# 	echo
# 	cp $installed_dir/settings/shell-personal/.bashrc-personal ~/.bashrc-personal
# 	cp $installed_dir/settings/shell-personal/.zshrc ~/.zshrc
# 	sudo cp -f $installed_dir/settings/shell-personal/.zshrc /etc/skel/.zshrc
# 	cp $installed_dir/settings/shell-personal/.zshrc-personal ~/.zshrc-personal
# 	cp $installed_dir/settings/fish/alias.fish ~/.config/fish/alias.fish
# 	echo
#
# 	echo "To personal Kvantum setup"
# 	echo
# 	[ -d $HOME"/.config/Kvantum" ] || mkdir -p $HOME"/.config/Kvantum"
# 	cp -r $installed_dir/settings/Kvantum/* $HOME/.config/Kvantum
# 	[ -d /etc/skel/.config/Kvantum ] || sudo mkdir -p /etc/skel/.config/Kvantum
# 	sudo cp -r $installed_dir/settings/Kvantum/* /etc/skel/.config/Kvantum
# 	echo
#
# 	echo
# 	echo "Changing icons for telegram"
# 	sh settings/telegram/adapt-telegram.sh
# 	echo

  print_done
else
  msg_warning "You are not in KDE PLASMA 6 (WAYLAND)"
fi

exit 0


