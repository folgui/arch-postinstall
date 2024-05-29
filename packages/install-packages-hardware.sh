#!/bin/bash

PKG_HARDWARE=(
'chaotic-aur/cpupower-gui'
'chaotic-aur/cpu-x'
'dmidecode'
'chaotic-aur/edid-decode-git'
'fwupd'
'gnome-firmware'
'gsmartcontrol'
'chaotic-aur/hardinfo'
'chaotic-aur/hw-probe'
'folgui/i-nex'
'intel-ucode'
'inxi'
'joyutils'
'lm_sensors'
'lshw'
'nvme-cli'
'chaotic-aur/openrgb'
'psensor'
'smartmontools'
'chaotic-aur/upd72020x-fw'
'usbutils'
'wmctrl'
)

PKG_ANDROID=(
'android-file-transfer'
'android-tools'
'android-udev'
'libmtp'
'mtpfs'
)

PKG_LOGITECH=(
'folgui/g810-led-git'
'folgui/g910-gkeys-git'
'folgui/g9xled'
'folgui/gkeybind'
'folgui/keyleds'
'folgui/keyboard-center'
'libratbag'
'chaotic-aur/logiops'
'folgui/ltunify'
'piper'
'solaar'
)

PKG_DNI=(
'folgui/ca-certificates-fnmt'
'folgui/ca-certificates-dnie'
'ccid'
'opensc'
'pcsc-tools'
)

echo
tput setaf 3
echo "####################################"
echo "### Installing HARDWARE packages ###"
echo "####################################"
tput sgr0
echo

sudo pacman --noconfirm --needed -S ${PKG_HARDWARE[@]}
sudo pacman --noconfirm --needed -S ${PKG_ANDROID[@]}
sudo pacman --noconfirm --needed -S ${PKG_LOGITECH[@]}
sudo pacman --noconfirm --needed -S ${PKG_DNI[@]}

sudo groupadd plugdev
sudo gpasswd -a $user plugdev

echo
tput setaf 6
echo "############"
echo "### DONE ###"
echo "############"
tput sgr0
echo

