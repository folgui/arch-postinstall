#!/bin/bash

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

echo
tput setaf 3
echo "#####################################"
echo "### Installing INTEL GPU packages ###"
echo "#####################################"
tput sgr0
echo

echo "INTEL iGPU MESA packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_MESA[@]}
echo "INTEL GPU VULKAN packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_VULKAN[@]}
echo "INTEL GPU VA-API Harware Acceleration packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_VAAPI[@]}
echo "INTEL GPU OPENCL-CUDA packages..."
sudo pacman --noconfirm --needed -S ${PKG_GPU_INTEL_OPENCL_CUDA[@]}

echo
tput setaf 6
echo "############"
echo "### DONE ###"
echo "############"
tput sgr0
echo


