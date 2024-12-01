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

PKG_GPU_AMD_DRIVERS_X11=(
  #xf86-video-amdgpu
  #xf86-video-ati
)

PKG_GPU_AMD_MESA=(
  'mesa'
  'lib32-mesa'
  'mesa-demos'
  'lib32-mesa-demos'
  'mesa-utils'
)

PKG_GPU_AMD_VULKAN=(
  'vulkan-headers'
  'vulkan-tools'
  'vulkan-icd-loader'
  'lib32-vulkan-icd-loader'
  'vkd3d'
  'lib32-vkd3d'
  'vulkan-mesa-layers'
  'lib32-vulkan-mesa-layers'
  'amdvlk'
  'lib32-amdvlk'
  'vulkan-radeon'
  'lib32-vulkan-radeon'
  'vulkan-validation-layers'
)

PKG_GPU_AMD_VAAPI=(
  '###AMD_Harware_Acceleration_VA-API'
  'libva'
  'lib32-libva'
  'libva-utils'
  'libva-mesa-driver'
  'lib32-libva-mesa-driver'
)

PKG_GPU_AMD_VDPAU=(
  '###AMD_Harware_Acceleration_VDPAU'
  'libvdpau'
  'lib32-libvdpau'
  'vdpauinfo'
  'mesa-vdpau'
  'lib32-mesa-vdpau'
  'libvdpau-va-gl'
)

PKG_GPU_AMD_OPENCL_CUDA=(
  '###AMD_GPGPU_OpenCL_CUDA'
  'opencl-headers'
  'opencl-mesa'
  'lib32-opencl-mesa'
  'clinfo'
  'ocl-icd'
  'lib32-ocl-icd'
)

PKG_GPU_AMD_TOOLS=(
  'amdgpu_top-bin'
  'chaotic-aur/lact'
  'nvtop'
  'switcheroo-control'
)

PKG_GPU_BENCHMARKS=(
  'glmark2'
  '#virtualgl'
)

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "Installing AMD GPU packages"

msg_info "AMD GPU MESA packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_MESA[@]}
msg_info "AMD GPU VULKAN packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_VULKAN[@]}
msg_info "AMD GPU VA-API Harware Acceleration packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_VAAPI[@]}
msg_info "AMD GPU VDPAU Harware Acceleration packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_VDPAU[@]}
msg_info "AMD GPU OPENCL-CUDA packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_OPENCL_CUDA[@]}
msg_info "AMD GPU Tool packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_TOOLS[@]}
msg_info "GPU Benchmark packages"
sudo pacman --noconfirm --needed -S ${PKG_GPU_BENCHMARKS[@]}
sudo systemctl enable lactd.service
sudo systemctl start lactd.service
sudo systemctl enable --now switcheroo-control

print_done

exit 0
