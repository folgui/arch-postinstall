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

PKG_DOCKER=(
'docker'
'docker-compose'
#aur/dockstation
'chaotic-aur/lazydocker'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING DOCKER PACKAGES"

msg_info "Installing docker packages"
sudo pacman --noconfirm --needed -S ${PKG_DOCKER[@]}

msg_info "Adding user to docker group"
user=$(whoami)
sudo gpasswd -a $user docker


msg_info "Enabling and starting docker service ..."
systemctl is-enabled --quiet docker.service || sudo systemctl enable docker.service
systemctl is-active --quiet docker.service || sudo systemctl start docker.service

msg_info "Creating portainer container"
sudo docker pull portainer/portainer-ce:latest
sudo docker volume create portainer_data
sudo docker run -d -p 9000:9000 -p 9443:9443 --name=portainer --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

msg_success "Open http://localhost:9000 in browser to access portainer"

print_done

exit 0

