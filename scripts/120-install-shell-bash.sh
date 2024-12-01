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

PKG_REQUIREMENTS=(
'curl'
'git'
'wget'
)

PKG_BASH=(
'bash'
'bash-completion'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))
bashPath="/home/"$USER"/.bashrc"

source ./BashHelper/config.sh
source ./BashHelper/common.sh

# https://wiki.archlinux.org/title/bash
# Framework: Oh My BASH (https://github.com/ohmybash/oh-my-bash)

print_title "INSTALL BASH SHELL AND SETUP"

msg_info "Creating backup of .bashrc file ..."
cp ~/.bashrc ~/.bashrc.$DATE_NOW.bak

msg_info "Checking for required packages ..."
sudo pacman -S --noconfirm --needed ${PKG_REQUIREMENTS[@]}

msg_info "Installing BASH packages ..."
#sudo pacman -S --noconfirm --needed bash
#sudo pacman -S --noconfirm --needed bash-completion
sudo pacman --noconfirm --needed -S ${PKG_BASH[@]}

if [[ -d ~/.oh-my-bash ]]; then
    msg_info "Oh-My-BASH already installed via GIT"
else
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
fi

msg_info "Update framework with: '$ upgrade_oh_my_bash' (alias upomb)"

msg_info "Updating BASHRC with personal settings"

# Enable command auto-correction, not by default
FIND='# ENABLE_CORRECTION="true"'
REPLACE='ENABLE_CORRECTION="true"'
sed -i "s/$FIND/$REPLACE/g" $bashPath

# Change theme
FIND='OSH_THEME="font"'
REPLACE='OSH_THEME="agnoster" # agnoster, mairan, powerbash10k, powerline, powerline-icon'
sed -i "s/$FIND/$REPLACE/g" $bashPath

print_done

exit 0
