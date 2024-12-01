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

PKG_GPU_NVIDIA_DRIVERS=(
'nvidia'
'nvidia-dkms'
'nvidia-settings'
'nvidia-utils'
'lib32-nvidia-utils'
)

PKG_GPU_NVIDIA_VULKAN=(
'vulkan-tools'
'vulkan-icd-loader'
'lib32-vulkan-icd-loader'
'vkd3d'
'lib32-vkd3d'
)

PKG_GPU_NVIDIA_VDPAU=(
'libvdpau'
'lib32-libvdpau'
'libva-utils'
'vdpauinfo'
)

PKG_GPU_NVIDIA_OPENCL_CUDA=(
'cuda'
'cudnn'
'opencl-nvidia'
'lib32-opencl-nvidia'
'ffnvcodec-headers'
'libxnvctrl'
'clinfo'
'ocl-icd'
'lib32-ocl-icd'
'opencl-headers'
)

PKG_GPU_NVIDIA_TOOLS=(
'nvtop'
)


script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "Installing NVIDIA GPU packages"

msg_info "NVIDIA GPU DRIVERS..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_DRIVERS[@]}
msg_info "NVIDIA GPU VULKAN packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_VULKAN[@]}
msg_info "NVIDIA GPU VDPAU Harware Acceleration packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_VDPAU[@]}
msg_info "NVIDIA GPU OPENCL-CUDA packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_OPENCL_CUDA[@]}
msg_info "NVIDIA GPU Tool packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_TOOLS[@]}

print_done

# exit the right way
exit 0
