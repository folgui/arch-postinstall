#!/bin/bash

PKG_DEVELOP=(
'git'
'qt5-base'
'qt5-doc'
'qt5-tools'
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



echo
tput setaf 3
echo "############################"
echo "### DEVELOPMENT PACKAGES ###"
echo "############################"
tput sgr0
echo

sudo pacman --noconfirm --needed -S ${PKG_DEVELOP[@]}

echo
tput setaf 6
echo "############"
echo "... Done ..."
echo "############"
tput sgr0
echo

