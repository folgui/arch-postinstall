#!/bin/bash

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
'libva-vdpau-driver'
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
'chaotic-aur/amdguid-glow-bin'
#radeontop
)

echo
tput setaf 3
echo "###################################"
echo "### Installing AMD GPU packages ###"
echo "###################################"
tput sgr0
echo

echo "AMD GPU MESA packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_MESA[@]}
echo "AMD GPU VULKAN packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_VULKAN[@]}
echo "AMD GPU VA-API Harware Acceleration packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_VAAPI[@]}
echo "AMD GPU VDPAU Harware Acceleration packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_VDPAU[@]}
echo "AMD GPU OPENCL-CUDA packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_OPENCL_CUDA[@]}
echo "AMD GPU Tool packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_AMD_TOOLS[@]}

echo
tput setaf 6
echo "############"
echo "### DONE ###"
echo "############"
tput sgr0
echo


