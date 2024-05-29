#!/bin/bash

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
'chaotic-aur/davinci-resolve'
'kdenlive'
'openshot'
#pitivi
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

echo
tput setaf 3
echo "################################################################"
echo "################### Utilities"
echo "################################################################"
tput sgr0
echo

sudo pacman --noconfirm --needed -S ${PKG_AUDIO[@] }
sudo pacman --noconfirm --needed -S ${PKG_PIPEWIRE[@] }
sudo pacman --noconfirm --needed -S ${PKG_PLAYERS[@] }
sudo pacman --noconfirm --needed -S ${PKG_EDITORS[@] }
sudo pacman --noconfirm --needed -S ${PKG_TOOLS[@]}
sudo pacman --noconfirm --needed -S ${PKG_CODECS[@]}

echo
tput setaf 6
echo "################################################################"
echo "################### Done"
echo "################################################################"
tput sgr0
echo

