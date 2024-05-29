#!/bin/bash

PKG_SYSTEM=(
'folgui/chkservice'
'cifs-utils'
'cockpit'
'cockpit-machines'
'cockpit-packagekit'
'cockpit-storaged'
'cronie'
'folgui/cylon'
'ddrescue'
'folgui/ddrescue-gui'
'chaotic-aur/downgrade'
'folgui/efibooteditor'
'efibootmgr'
'etc-update'
'foremost'
'fuseiso'
'gnome-disk-utility'
'gparted'
#grub-customizer
'folgui/grub2-theme-preview'
'lfs'
'lsb-release'
'chaotic-aur/memtest86-efi'
'os-prober'
'folgui/pyakm'
'procs'
'chaotic-aur/stacer'
'systemdgenie'
'chaotic-aur/systemd-manager-git'
'systemd-ui'
'testdisk'
'chaotic-aur/update-grub'
'zps'
)

PKG_FIRMWARE=(
'chaotic-aur/aic94xx-firmware'
'chaotic-aur/wd719x-firmware'
)

echo
tput setaf 3
echo "################################################################"
echo "################### Utilities"
echo "################################################################"
tput sgr0
echo

sudo pacman --noconfirm --needed -S ${PKG_SYSTEM[@]}

echo
tput setaf 6
echo "################################################################"
echo "################### Done"
echo "################################################################"
tput sgr0
echo

