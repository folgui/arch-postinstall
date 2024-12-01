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

script_dir=$(dirname $(readlink -f $(basename $PWD)))
fecha=$(date '+%y-%m-%d_%H-%M')

source ../BashHelper/config.sh
source ../BashHelper/common.sh

function add_repo_with_key() {
    local _reponame=${1}
    local _reposerver=${2}
    local _repokey=${3}

    if cat "/etc/pacman.conf" | grep -qFe ${_reponame}
        then
            msg_warning "El repositorio ${_reponame^^} ya existe en /etc/pacman.conf"
            #dialog --clear --no-lines --msgbox "El repositorio ${_reponame} ya existe en /etc/pacman.conf" 10 50
        else
            file_add_line '' '/etc/pacman.conf' >/dev/null
            file_add_line "[${_reponame}]" "/etc/pacman.conf" >/dev/null
            file_add_line "Server = ${_reposerver}" "/etc/pacman.conf" >/dev/null
            if [[ ! ${_repokey} == '' ]]; then
                #pacman-key --recv-keys 8DC2CE3A3D245E64
                #pacman-key --keyserver hkp://keys.gnupg.net:80 --recv-keys C1A60EACE707FDA5
                sudo pacman-key --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys ${_repokey} >/dev/null
                #pacman-key --finger ${_repokey}
                sudo pacman-key --lsign-key ${_repokey} >/dev/null
            fi
			msg_success "- El repositorio [${_reponame}] se ha agregado correctamente."
            #dialog --clear --no-lines --msgbox "El repositorio ${reponame} se ha procesado correctamente" 10 50
    fi

}

function add_repo_without_key() {
    local _reponame=${1}
    local _reposerver=${2}
    local _reposiglevel=${3}

    if cat "/etc/pacman.conf" | grep -qFe ${_reponame}
        then
            msg_warning "El repositorio ${_reponame^^} ya existe en /etc/pacman.conf"
            #dialog --clear --no-lines --msgbox "El repositorio ${_reponame} ya existe en /etc/pacman.conf" 10 50
        else
            file_add_line "" "/etc/pacman.conf" >/dev/null
            file_add_line "[${_reponame}]" "/etc/pacman.conf" >/dev/null
            if [[ ! ${_reposiglevel} == '' ]]; then
                file_add_line "SigLevel = ${_reposiglevel}" "/etc/pacman.conf" >/dev/null
            fi
            file_add_line "Server = ${_reposerver}" "/etc/pacman.conf" >/dev/null
            #dialog --clear --no-lines --msgbox "El repositorio ${reponame} se ha procesado correctamente" 10 50
			msg_success "- El repositorio [${_reponame}] se ha agregado correctamente."
    fi
}

if [ "$EUID" -ne 0 ]
  then echo "Please run script as superuser"
  exit 1
fi

print_title "ADDING ARCHLINUX REPOSITORIES TO PACMAN.CONF"

## Backup of /etc/pacman.conf
file_copy "/etc/pacman.conf" "/etc/pacman.conf.${fecha}" >/dev/null

# Signed
add_repo_with_key 'alerque' 'https://arch.alerque.com/$arch' '63CC496475267693'
add_repo_with_key 'andontie-aur' 'https://aur.andontie.net/$arch' '72BF227DD76AE5BF'
add_repo_with_key 'arcanisrepo' 'https://repo.arcanis.me/$repo/$arch' 'BD2AC8C5E989490C'

# Unsigned - Users will need to add the following to these entries: SigLevel = PackageOptional
#add_repo_without_key 'core-alucryd' 'https://pkgbuild.com/~alucryd/$repo/$arch' 'Optional TrustAll'
add_repo_without_key 'extra-alucryd' 'https://pkgbuild.com/~alucryd/$repo/$arch' 'Optional TrustAll'
add_repo_without_key 'multilib-alucryd' 'https://pkgbuild.com/~alucryd/$repo/$arch' 'Optional TrustAll'
add_repo_without_key 'dx37essentials' 'https://dx3756.ru/$repo/$arch' 'Optional TrustAll'
print_done

# exit the right way
exit 0

