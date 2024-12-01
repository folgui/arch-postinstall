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

PKG_BACKUP=(
  '#chaotic-aur/backintime'
  '#chaotic-aur/backintime-cli'
  'bup'
  '#grsync'
  'kup'
  '#chaotic-aur/pika-backup'
  'rsnapshot'
  'folgui/rsnapshot-systemd-timers'
  'timeshift'
  'chaotic-aur/timeshift-autosnap'
  'vorta'
  'folgui/vorta-root'
)

PKG_BENCHMARKS=(
  '#fio'
  'hyperfine'
  'glmark2'
  'arcolinux_repo_3party/gputest'
  'iperf3'
  'kdiskmark'
)

PKG_COMPRESS=(
  'bzip2'
  'cabextract'
  'cpio'
  #file-roller
  'gzip'
  'p7zip'
  'chaotic-aur/peazip'
  'lzop'
  'rar'
  'sharutils'
  'unace'
  'unzip'
  'wget'
  'zip'
)

PKG_DOCKER=(
  'docker'
  'docker-compose'
  #aur/dockstation
  'chaotic-aur/lazydocker'
)

PKG_UTILITIES=(
  'chaotic-aur/appimagelauncher'
  'appmenu-gtk-module'
  'folgui/arronax'
  #'aur/autofirma-bin'
  'folgui/autofirma'
  'folgui/aurutils'
  'bat'
  'chaotic-aur/bauh'
  'bitwarden'
  'bitwarden-cli'
  'bleachbit'
  'bottom'
  'btop'
  'catfish'
  'chaotic-aur/cpufetch-git'
  'folgui/cylon'
  #chaotic-aur/debtap
  'dialog'
  'difftastic'
  'dos2unix'
  'duf'
  'dust'
  'eza'
  'chaotic-aur/fastfetch'
  'fd'
  #fff
  'figlet'
  'fkill'
  'flatpak'
  'chaotic-aur/fsearch'
  #fzf
  'folgui/fzpac-git'
  'htop'
  'glances'
  'glow'
  'gprename'
  'grex'
  #keepassxc
  'libnotify'
  #lsd
  'folgui/manpages-es'
  'folgui/manpages-es-extra'
  'meld'
  'folgui/moar'
  'nano'
  'ncdu'
  'neofetch'
  'neovim'
  'chaotic-aur/ocs-url'
  'chaotic-aur/octopi'
  'chaotic-aur/octopi-notifier-frameworks'
  'chaotic-aur/alpm_octopi_utils'
  'chaotic-aur/pace'
  'chaotic-aur/pacui'
  'pdfgrep'
  'folgui/pkgbrowser'
  'plocate'
  'progress'
  'procs'
  'pv'
  'ranger'
  'recoll'
  'reflector'
  'ripgrep-all'
  'ripgrep'
  #repgrep
  'rmlint-shredder'
  'sd'
  'tealdeer'
  #tldr
  'chaotic-aur/topgrade'
  'tree'
  'yad'
  'zoxide'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING GRAPHIC PACKAGES"

msg_info "Installing backup utility packages"
sudo pacman --noconfirm --needed -S ${PKG_BACKUP[@]}

msg_info "Installing benchmark packages"
sudo pacman --noconfirm --needed -S ${PKG_BENCHMARKS[@]}

msg_info "Installing compress packages"
sudo pacman --noconfirm --needed -S ${PKG_COMPRESS[@]}

msg_info "Installing docker packages"
sudo pacman --noconfirm --needed -S ${PKG_DOCKER[@]}

msg_info "Installing utility packages"
sudo pacman --noconfirm --needed -S ${PKG_UTILITIES[@]}

msg_info "Updating tldr database"
sudo tldr --update

msg_info "Checking for moar in environment vars, otherwise adding it"
#export MOAR='--statusbar=bold --no-linenumbers'
#Setting moar as your default pager:
#export PAGER=/usr/bin/moar

msg_info "Configuración personalizada de chaotic-aur/timeshift-autosnap"
# Mirar systemd services para modificar

print_done

exit 0
