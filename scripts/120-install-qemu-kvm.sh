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

PKG_QEMU=(
'bridge-utils'
'dnsmasq'
'dhclient'
'openbsd-netcat'
'iptables-nft'
'vde2'
'dmidecode'
'qemu-full'
'virt-manager'
'virt-viewer'
'virt-install'
'libvirt'
'libvirt-dbus'
'edk2-ovmf'
'swtpm'
'virglrenderer'
'libguestfs'
'spice'
'spice-protocol'
'virtiofsd'
'vulkan-virtio'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

#tutorials https://www.youtube.com/playlist?list=PLlloYVGq5pS6WhIdpcrgoj_XszquIyKCQ
#https://computingforgeeks.com/install-kvm-qemu-virt-manager-arch-manjar/

print_title "INSTALL QEMU-KVM VIRTUALIZATION "

msg_info "Installing packages ..."
sudo pacman -S --noconfirm --needed ${PKG_QEMU[@]}
# sudo pacman -S --noconfirm --needed bridge-utils
# sudo pacman -S --noconfirm --needed dnsmasq
# sudo pacman -S --noconfirm --needed dhclient
# sudo pacman -S --noconfirm --needed openbsd-netcat
# sudo pacman -S --noconfirm --needed iptables-nft
# sudo pacman -S --noconfirm --needed vde2
# sudo pacman -S --noconfirm --needed dmidecode
# sudo pacman -S --noconfirm --needed qemu-full
# sudo pacman -S --noconfirm --needed virt-manager
# sudo pacman -S --noconfirm --needed virt-viewer
# sudo pacman -S --noconfirm --needed virt-install
# sudo pacman -S --noconfirm --needed libvirt
# sudo pacman -S --noconfirm --needed libvirt-dbus
# sudo pacman -S --noconfirm --needed edk2-ovmf
# sudo pacman -S --noconfirm --needed swtpm
# sudo pacman -S --noconfirm --needed virglrenderer
# sudo pacman -S --noconfirm --needed libguestfs
# sudo pacman -S --noconfirm --needed spice
# sudo pacman -S --noconfirm --needed spice-protocol
# # for guests
# #sudo pacman -S --noconfirm --needed spice-vdagent
# sudo pacman -S --noconfirm --needed virtiofsd
# sudo pacman -S --noconfirm --needed vulkan-virtio
# #sudo pacman -S --noconfirm --needed quickemu
# #sudo pacman -S --noconfirm --needed quickgui-bin

msg_info "Starting libvirt service ..."
#sudo systemctl enable libvirtd.service
#sudo systemctl start libvirtd.service
systemctl is-enabled --quiet libvirtd.service || sudo systemctl enable libvirtd.service
systemctl is-active --quiet libvirtd.service || sudo systemctl start libvirtd.service

msg_info "Enabling nested virtualzation ..."
if grep -q "options kvm-intel nested=1" /etc/modprobe.d/kvm-intel.conf; then
    msg_success "Nested virtualization for Intel CPU already enabled."
else
    echo -e "options kvm-intel nested=1" | sudo tee -a /etc/modprobe.d/kvm-intel.conf
fi

#echo -e "options kvm-intel nested=1" | sudo tee -a /etc/modprobe.d/kvm-intel.conf
if grep -q "options kvm-amd nested=1" /etc/modprobe.d/kvm-amd.conf; then
    msg_success "Nested virtualization for AMD CPU already enabled."
else
    echo -e "options kvm-amd nested=1" | sudo tee -a /etc/modprobe.d/kvm-amd.conf
fi
sudo modprobe kvm
sudo modprobe kvm-amd
#sudo modprobe kvm-intel

msg_info "Adding user to virtualization groups (kvm,polkitd,libvirt,etc) ..."
#sudo groupadd libvirt, kvm, qemu
getent group libvirt || sudo groupadd libvirt
getent group kvm || sudo groupadd kvm
getent group qemu || sudo groupadd qemu
getent group polkitd || sudo groupadd polkitd

## Change your username here
#read -p "What is your login?
#It will be used to add this user to the 2 different groups : " user

local user=$(whoami)
#sudo usermod -a -G libvirt $user
#sudo usermod -a -G kvm $user
#sudo usermod -a -G qemu $user
#sudo usermod -a -G polkitd $user
sudo gpasswd -a $user libvirt
sudo gpasswd -a $user kvm
sudo gpasswd -a $user qemu
sudo gpasswd -a $user polkitd
# if ingroup libvirt $user; then
#     msg_success "You are already in libvirt group"
# else
#     msg_info "Adding user to libvirt group ..."
#     sudo gpasswd -a $user libvirt
# fi

msg_info "Configuring settings for QEMU/KVM ..."

## Configuring user to run virtual machine from command-line and avoid permission errors...
## Create /etc/udev/rules.d/10-qemu.rules with this content to avoid QEMU permission errors when running as a normal user.
if [[ -f /etc/udev/rules.d/10-qemu.rules ]]; then
    if grep -q 'GROUP="kvm"' /etc/udev/rules.d/10-qemu.rules; then
        echo ""
    else
        echo '
        SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"' | sudo tee --append /etc/udev/rules.d/10-qemu.rules
    fi
fi
# sudo cat << EOF > /etc/udev/rules.d/10-qemu.rules
# SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
# EOF

## Avoid password request each time we launch a Virtual Machine..."
if [[ ! -f /etc/polkit-1/rules.d/50-org.libvirt.unix.manage.rules ]]; then
sudo cat << EOF > /etc/polkit-1/rules.d/50-org.libvirt.unix.manage.rules
/* Allow users in wheel group to manage the libvirt daemon without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" &&
        subject.isInGroup("wheel")) {
            return polkit.Result.YES;
    }
});

/* Allow users in folgui group to manage the libvirt daemon without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" &&
        subject.isInGroup("folgui")) {
            return polkit.Result.YES;
    }
});

/* Allow users in kvm group to manage the libvirt daemon without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" &&
        subject.isInGroup("kvm")) {
            return polkit.Result.YES;
    }
});

/* Allow users in libvirt group to manage the libvirt daemon without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" &&
        subject.isInGroup("libvirt")) {
            return polkit.Result.YES;
    }
});

/* Allow users in qemu group to manage the libvirt daemon without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" &&
        subject.isInGroup("qemu")) {
            return polkit.Result.YES;
    }
});
EOF
fi

## Defining file-based permissions for users in the libvirt group to manage virtual machines...
## To define file-based permissions for users in the libvirt group to manage virtual machines, uncomment:
sudo sed -i "s/^#unix_sock_group =/unix_sock_group =/g" /etc/libvirt/libvirtd.conf
sudo sed -i "s/^#unix_sock_ro_perms =/unix_sock_ro_perms =/g" /etc/libvirt/libvirtd.conf
sudo sed -i "s/^#unix_sock_rw_perms =/unix_sock_rw_perms =/g" /etc/libvirt/libvirtd.conf

## Adding UEFI settings to qemu.conf
if grep -q '/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd' /etc/libvirt/qemu.conf; then
    echo ""
else
    echo '
    nvram = [
        "/usr/share/ovmf/x64/OVMF_CODE.fd:/usr/share/ovmf/x64/OVMF_VARS.fd"
    ]' | sudo tee --append /etc/libvirt/qemu.conf
fi

msg_info "Setting up networking services ..."
sudo virsh net-define /etc/libvirt/qemu/networks/default.xml
sudo virsh net-autostart default
#sudo virsh net-start default
#sudo virsh net-autostart
sudo systemctl restart libvirtd.service

## COMPARTICIÓN HOST <-> GUEST
# A NIVEL DE HOST:
# Necesitamos añadir un dispostivo virtiofs.
# Virtiofs necesita memoria compartida para funcionar. Se habilita en la configuración de hardwware > memoria > habilitar memoria compartida (enable shared memory).
# A continuación, pinchamos en "Añadir hardware" en la parte inferior de la columna de la izquierda seleccionamos "Sistema de archivos" y rellenamos con:
# Driver: virtiofs
# Source path: /mnt/vfs_share
# Target path: share
# A NIVEL DE GUEST:
# mkdir ~/share
# A continuación, podemos montar la carpeta compartida con:
# sudo mount -t virtiofs share /home/folgui/share
# Si queremos que el cambio sea permanente, lo meteríamos en el /etc/fstab con :
# share   /home/folgui/share       virtiofs        defaults        0       0

msg_info "Creating shared folder on HOST system ..."
sudo mkdir -p /mnt/vfs_share
sudo chown $USER:$USER /mnt/vfs_share

print_line
echo " GUEST TRICKS:"
echo " -------------"
echo ""
echo " In HOST:"
echo " * Top Menu of Virtmanager > File | Virtual Machine | View | Send Key"
echo " * Select View > Scale display > Always"
echo ""
echo " In GUEST:"
echo " * Display settings of desktop manager and select native resolution."
echo " * Select Virtual Machine > Redirect USB Device and it will be available for guest."
echo ""
echo " NOTES:"
echo " * Better performance with Virtual Machine under X11 than Wayland."
echo " * QEMU is much better virtualization system than VirtualBox in performance terms."
print_line

print_done

exit 0
