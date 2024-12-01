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

PKG_REQUIREMENTS=(
    'curl'
    'git'
    'wget'
)

PKG_ZSH=(
    'zsh'
    'zsh-completions'
    'zsh-autosuggestions'
    'zsh-syntax-highlighting'
    'zsh-theme-powerlevel10k'
    'ttf-dejavu-nerd'
    'chaotic-aur/ttf-meslo-nerd-font-powerlevel10k'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))
zshPath="/home/"$USER"/.zshrc"

source ./BashHelper/config.sh
source ./BashHelper/common.sh

# https://wiki.archlinux.org/title/zsh
# Framework: Oh My ZSH (https://github.com/ohmyzsh/ohmyzsh)

print_title "INSTALL ZSH SHELL AND SETUP"

if [[ -f ~/.zshrc ]]; then
    msg_info "Creating backup of .zshrc file ..."
    cp ~/.zshrc ~/.zshrc.$DATE_NOW.bak
fi

msg_info "Checking for required packages ..."
sudo pacman -S --noconfirm --needed ${PKG_REQUIREMENTS[@]}

msg_info "Installing ZSH packages ..."
sudo pacman --noconfirm --needed -S ${PKG_ZSH[@]}

# Change SHELL through commandline (not neccesary as Oh-My-ZSH does it upon installation):
#chsh -s /bin/zsh folgui
#chsh -s /bin/zsh $USER

if [[ -d ~/.oh-my-zsh ]]; then
    msg_info "Oh-My-ZSH already installed via GIT"
else
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

msg_info "Update framework with: '$ upgrade_oh_my_zsh' (alias upomz)"

msg_info "Installing ZSH Completions from GIT into Oh-My-ZSH"
if [[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions ]]; then
    msg_info "ZSH Completions already exists in Oh-My-ZSH"
else
    git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
fi

msg_info "Installing ZSH Syntax highlighting from GIT into Oh-My-ZSH"
if [[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
    msg_info "ZSH Syntax highlighting already exists in Oh-My-ZSH"
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

msg_info "Installing ZSH Autosuggestions from GIT into Oh-My-ZSH ..."
if [[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
    msg_info "ZSH Autosuggestions already exists in Oh-My-ZSH"
else
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

msg_info "Adding installed plugins to .zshrc"
FIND='plugins=(git)'
REPLACE='plugins=(git archlinux sudo zsh-completions zsh-syntax-highlighting zsh-autosuggestions)'
sed -i "s/$FIND/$REPLACE/g" $zshPath

#msg_info "Installing POWERLEVEL10K theme from system/repositories"
# if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
#     msg_info "We add a line with the powerlevel10k theme at ~/.zshrc file ..."
#     echo '
#     source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' | sudo tee --append $zshPath
# fi

msg_info "Installing POWERLEVEL10K theme from GIT ..."
if [[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
    msg_info "POWERLEVEL10K theme already exists in Oh-My-ZSH"
else
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
fi

msg_info "Updating the ZSH_THEME line"
FIND='ZSH_THEME="random"'
REPLACE='#ZSH_THEME="random"'
sed -i "s/$FIND/$REPLACE/g" $zshPath
FIND='ZSH_THEME="robbyrussell"' # connfigured theme after Oh-My-ZSH installation
REPLACE='ZSH_THEME="powerlevel10k/powerlevel10k"'
sed -i "s/$FIND/$REPLACE/g" $zshPath

msg_info "The first time you access ZSH prompt, if powerlevel10 it not configured previously, it launches configure process."
msg_info "To configure powerlevel10k later, use the command: p10k configure"

msg_info "Updating ZSHRC with personal settings"
#msg_info "We add a line to ~/.zshrc to quiet the prompt ..."
# echo '
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet' | sudo tee --append $zshPath

# Enable command auto-correction, not by default
FIND='# ENABLE_CORRECTION="true"'
REPLACE='ENABLE_CORRECTION="true"'
sed -i "s/$FIND/$REPLACE/g" $zshPath

if grep -q p10k $zshPath; then
    msg_success "Powerlevel10k already in .zshrc"
else
    echo '
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' | sudo tee --append $zshPath
fi

print_done

exit 0
