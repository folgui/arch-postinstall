#!/bin/bash

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

echo
tput setaf 3
echo "###################################"
echo "### Installing AMD GPU packages ###"
echo "###################################"
tput sgr0
echo

echo "NVIDIA GPU DRIVERS..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_DRIVERS[@]}
echo "NVIDIA GPU VULKAN packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_VULKAN[@]}
echo "NVIDIA GPU VDPAU Harware Acceleration packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_VDPAU[@]}
echo "AMD GPU OPENCL-CUDA packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_NVIDIA_OPENCL_CUDA[@]}

echo
tput setaf 6
echo "############"
echo "### DONE ###"
echo "############"
tput sgr0
echo


