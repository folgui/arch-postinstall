#!/bin/bash
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

PKG_BACKUP=(
'chaotic-aur/backintime'
'chaotic-aur/backintime-cli'
'bup'
#grsync
'kup'
'chaotic-aur/pika-backup'
#timeshift
'chaotic-aur/vorta'
)

PKG_BENCHMARKS=(
'fio'
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
#chaotic-aur/debtap
'dialog'
'difftastic'
'dos2unix'
'duf'
'dust'
'exa'
'chaotic-aur/fastfetch'
'fd'
#fff
'figlet'
'folgui/fkill'
'flatpak'
'chaotic-aur/fsearch'
#fzf
'folgui/fzpac-git'
'htop'
'glances'
'glow'
'gprename'
#keepassxc
'libnotify'
#lsd
'folgui/manpages-es'
'folgui/manpages-es-extra'
'meld'
#folgui/moar
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
'pv'
'recoll'
'reflector'
'ripgrep-all'
#ripgrep
#repgrep
'rmlint-shredder'
'sd'
'tealdeer'
#tldr
'chaotic-aur/topgrade'
'tree'
'yad'
)

echo
tput setaf 4
echo "#############################"
echo " Installing UTILITY packages "
echo "#############################"
tput sgr0
echo


sudo pacman --noconfirm --needed -S ${PKG_BACKUP[@]}
sudo pacman --noconfirm --needed -S ${PKG_BENCHMARKS[@]}
sudo pacman --noconfirm --needed -S ${PKG_COMPRESS[@]}
sudo pacman --noconfirm --needed -S ${PKG_DOCKER[@]}
sudo pacman --noconfirm --needed -S ${PKG_UTILITIES[@]}

echo
tput setaf 2
echo ">>> DONE! <<<"
tput sgr0
echo

