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

PKG_GPU_INTEL_DRIVERS_X11=(
#xf86-video-intel
)

PKG_GPU_INTEL_MESA=(
'mesa'
'lib32-mesa'
'mesa-demos'
'lib32-mesa-demos'
'mesa-utils'
)

PKG_GPU_INTEL_VULKAN=(
'vulkan-tools'
'vulkan-icd-loader'
'lib32-vulkan-icd-loader'
'vkd3d'
'lib32-vkd3d'
'vulkan-mesa-layers'
'lib32-vulkan-mesa-layers'
'vulkan-intel'
'lib32-vulkan-intel'
)

PKG_GPU_INTEL_VAAPI=(
'###AMD_Harware_Acceleration_VA-API'
'intel-media-driver'
'libva'
'lib32-libva'
'libva-utils'
'libva-intel-driver'
'lib32-libva-intel-driver'
'libva-mesa-driver'
'lib32-libva-mesa-driver'
)
PKG_GPU_INTEL_OPENCL_CUDA=(
'###INTEL_GPGPU_OpenCL_CUDA'
'intel-compute-runtime'
'beignet'
'opencl-headers'
'opencl-mesa'
'lib32-opencl-mesa'
'clinfo'
'ocl-icd'
'lib32-ocl-icd'
)
PKG_GPU_INTEL_TOOLS=(
'nvtop'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "Installing INTEL GPU packages"

print_subtitle "Installing INTEL GPU packages"
#sudo pacman -S --noconfirm xf86-video-intel vulkan-intel lib32-vulkan-intel vulkan-swrast
msg_info "INTEL iGPU MESA packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_MESA[@]}
msg_info "INTEL GPU VULKAN packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_VULKAN[@]}
msg_info "INTEL GPU VA-API Harware Acceleration packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_VAAPI[@]}
msg_info "INTEL GPU OPENCL-CUDA packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_OPENCL_CUDA[@]}
msg_info "INTEL GPU Tool packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_TOOLS[@]}

print_done

# exit the right way
exit 0
