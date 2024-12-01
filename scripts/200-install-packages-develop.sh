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

PKG_DEVELOP=(
  'git'
  'just'
  'qt6-base'
  'qt6-doc'
  'qt6-tools'
  'qtcreator'
)

PKG_DEVELOP_OLD=(
  'chaotic-aur/abricotine'
  'archiso'
  'bluefish'
  'ccache'
  'chaotic-aur/gpt4all-chat-git'
  'dotnet-host'
  'dotnet-sdk'
  'dotnet-runtime'
  'firefox-developer-edition'
  'firefox-developer-edition-i18n-es-es'
  'gambas3-ide'
  'ghostwriter'
  'git'
  'gitg'
  'gitkraken'
  'gitui'
  'go'
  'grex'
  'jq'
  'jdk-openjdk'
  'jre-openjdk'
  'jre-openjdk-headless'
  'jdk8-openjdk'
  'jre8-openjdk'
  'jre8-openjdk-headless'
  'itstool'
  'lazygit'
  'meld'
  '#monodevelop-stable'
  'neovim'
  'neovim-qt'
  'netbeans'
  'nodejs'
  'npm'
  'pycharm-community-edition'
  'python-pip'
  'python-pipenv'
  'python-pipenv-to-requirements'
  'python-pipreqs'
  'python-pynvim'
  'python-virtualenv'
  'folgui/qarma-git'
  'qtcreator'
  'ruby'
  'rubygems'
  'sqlitebrowser'
  'tk'
  'typescript'
  'visual-studio-code-bin'
  'yamllint'
  '###_REPO_CHAOTIC-AUR'
  'android-studio'
  'jre8'
  'marktext-git'
  'zeal'
  '###_REPO_USERREPOSITORY'
  'vscodium-bin'
  'vscodium-bin-marketplace'
  '###_REPO_FOLGUI'
  'github-desktop-bin'
  '#Siguiente_para_Pycharm'
  '#liberica-jre-11-full-bin'
)

# python-pip - The official package installer for Python: . You can use pip to install packages from the Python Package Index and other indexes.
# python-pipx — Closely related to pip, but creates, for the user running it, an isolated environment for each application and its associated packages, preventing conflicts with system packages. Focused on packages that can be run from the command line directly as applications. You can use pipx to install packages from the Python Package Index and other indexes.
PKG_PYTHON=(
  'python'
  'python-pip'
  'python-pipx'
)

PKG_RUST=(
  'rustup'
  '#rust-analyzer'
)

PKG_NET=(
  'dotnet-runtime'
  'dotnet-sdk'
  'aspnet-runtime'
  'aspnet-targeting-pack'
)

PKG_NET7=(
  'dotnet-runtime-7.0'
  'dotnet-sdk-7.0'
  'aspnet-runtime-7.0'
  'aspnet-targeting-pack-7.0'
)
PKG_NET6=(
  'dotnet-runtime-6.0'
  'dotnet-sdk-6.0'
  'aspnet-runtime-6.0'
  'aspnet-targeting-pack-6.0'
)

PKG_LSP=(
  'bash-language-server'
  'python-lsp-server'
  'typescript-language-server'
  'yaml-language-server'
  'folgui/dockerfile-language-server-bin'
  'shfmt'
  'vscode-html-languageserver'
  'yarn'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALL DEVELOPMENT PACKAGES"

msg_info "Installing development packages ..."
sudo pacman --noconfirm --needed -S ${PKG_DEVELOP[@]}
sudo pacman --noconfirm --needed -S ${PKG_PYTHON[@]}
sudo pacman --noconfirm --needed -S ${PKG_RUST[@]}
sudo pacman --noconfirm --needed -S ${PKG_NET[@]}
#sudo pacman --noconfirm --needed -S ${PKG_NET7[@]}
#sudo pacman --noconfirm --needed -S ${PKG_NET6[@]}
sudo pacman --noconfirm --needed -S ${PKG_LSP[@]}

msg_info "Configuration and installation of Rust tools..."
#Configuring rust toolchain (stable, beta, nightly)
rustup default stable
rustup component add rust-analyzer
#Next ones are already included in toolchain stable installed above
rustup component add clippy
rustup component add rustfmt

print_done

exit 0
