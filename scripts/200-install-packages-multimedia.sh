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

PKG_AUDIO=(
'alsa-firmware'
'alsa-plugins'
'alsa-lib'
'alsa-utils'
'libcanberra'
'lib32-libcanberra'
'pavucontrol'
'plasma-pa'
'pulseeffects'
)

PKG_CODECS=(
'a52dec'
'aom'
'dav1d'
'faac'
'faad2'
'ffmpeg'
'ffmpegthumbnailer'
'ffmpegthumbs'
'flac'
'jasper'
'lame'
'libavif'
'libdca'
'libheif'
'libmad'
'libmpeg2'
'libtheora'
'libvorbis'
'libvpx'
'libwebp'
'libxv'
'mpg123'
'opus'
'rav1e'
'svt-av1'
'twolame'
'wavpack'
'x264'
'x265'
'xvidcore'
)

PKG_PIPEWIRE=(
'pipewire'
'lib32-pipewire'
'pipewire-alsa'
'pipewire-docs'
'pipewire-jack'
'lib32-pipewire-jack'
'pipewire-pulse'
'pipewire-zeroconf'
'wireplumber'
)

PKG_PLAYERS=(
'audacious'
'audacious-plugins'
'clementine'
'dragon'
'haruna'
'hypnotix'
#lollypop
#mplayer
'mpv'
'chaotic-aur/plex-media-player'
'smplayer'
'smplayer-skins'
'smplayer-themes'
#spotify-launcher
'strawberry'
'folgui/tv-lite'
'vlc'
'chaotic-aur/webtorrent-desktop-bin'
'chaotic-aur/youtube-music-bin'
'chaotic-aur/ytfzf'
'folgui/zvvonlinetv'
)

PKG_EDITORS=(
'audacity'
'avidemux-qt'
'flowblade'
'kdenlive'
'openshot'
'pitivi'
'shotcut'
#synfigstudio
)

PKG_TOOLS=(
'folgui/4kvideodownloader'
'aegisub'
'avidemux-qt'
'folgui/cine-encoder'
'clipgrab'
'easytag'
'chaotic-aur/filebot'
'folgui/gydl-git'
'handbrake'
'handbrake-cli'
#folgui/hybrid-encoder
'kid3-qt'
'chaotic-aur/makemkv'
'mediainfo'
#mediainfo-gui
'chaotic-aur/mediainfo-gui-qt'
'folgui/mkv-extractor-qt'
'mkvtoolnix-gui'
'chaotic-aur/mystiq'
'qwinff'
'shortwave'
'chaotic-aur/shutter-encoder'
'soundkonverter'
'chaotic-aur/subtitlecomposer'
'folgui/tiny-media-manager'
'folgui/video2x'
'chaotic-aur/webcamoid'
'youtube-dl'
)

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "INSTALLING MULTIMEDIA PACKAGES"

msg_info "Installing audio packages"
sudo pacman --noconfirm --needed -S ${PKG_AUDIO[@]}

msg_info "Installing codec packages"
sudo pacman --noconfirm --needed -S ${PKG_CODECS[@]}

msg_info "Installing pipewire packages"
sudo pacman --noconfirm --needed -S ${PKG_PIPEWIRE[@]}

msg_info "Installing audio/vídeo player packages"
sudo pacman --noconfirm --needed -S ${PKG_PLAYERS[@]}

msg_info "Installing audio/vídeo editor packages"
sudo pacman --noconfirm --needed -S ${PKG_EDITORS[@]}

msg_info "Installing multimedia tools packages"
sudo pacman --noconfirm --needed -S ${PKG_TOOLS[@]}

print_done

exit 0

