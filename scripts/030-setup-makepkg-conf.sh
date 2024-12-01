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

script_dir=$(dirname $(readlink -f $(basename $(pwd))))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "Modifying makepkg.conf with custom settings"

msg_info "Creating backup of /etc/makepkg.conf ..."
sudo cp /etc/makepkg.conf /etc/makepkg.conf.$DATE_NOW.bak

msg_info "Applying custom settings ..."

# GCC can automatically detect and enable safe architecture-specific optimizations with "native" option. Same with RUSTFLAGS.
FIND="-march=x86-64 -mtune=generic -O2"
REPLACE="-march=native -mtune=native -O3"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/makepkg.conf

FIND="-Cforce-frame-pointers=yes"
REPLACE="-Cforce-frame-pointers=yes -C target-cpu=native"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/makepkg.conf

# Parallel compilation. Users with multi-core/multi-processor systems can specify the number of jobs to run simultaneously.
sudo sed -i "s/^#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$(nproc)\"/g" /etc/makepkg.conf

# Remove creation of DEBUG files
FIND="purge debug lto"
REPLACE="purge !debug lto"
sudo sed -i "s/$FIND/$REPLACE/g" /etc/makepkg.conf

# Building from files in memory. As compiling requires many I/O operations and handling of small files, moving the working directory to a tmpfs may bring improvements in build times. BUILDDIR=/tmp/makepkg
FIND="#BUILDDIR="
REPLACE="BUILDDIR="
sudo sed -i "s/$FIND/$REPLACE/g" /etc/makepkg.conf

print_done

exit 0
