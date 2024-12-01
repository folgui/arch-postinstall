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

script_dir=$(dirname $(readlink -f $(basename `pwd`)))

source ./BashHelper/config.sh
source ./BashHelper/common.sh

print_title "KDE PLASMA SETTINGS"

if [[ -f ~/.local/share/user-places.xbel ]]; then
    msg_info "Creating backup of current user-places ..."
    cp ~/.local/share/user-places.xbel ~/.local/share/user-places.xbel.$DATE_NOW.bak
fi
msg_info "Restoring user-places ..."
cp $script_dir/settings/plasma/user-places.xbel ~/.local/share/user-places.xbel

msg_info "Appling KDE Plasma personal settings..."
### Yakuake
kwriteconfig6 --file ~/.config/yakuakerc --group Appearance --key BackgroundColorOpacity "65"
kwriteconfig6 --file ~/.config/yakuakerc --group Appearance --key Translucency "true"
kwriteconfig6 --file ~/.config/yakuakerc --group Window --key KeepOpen "false"
kwriteconfig6 --file ~/.config/yakuakerc --group Window --key ShowSystrayIcon "false"
kwriteconfig6 --file ~/.config/yakuakerc --group Window --key ShowTabBar "false"
kwriteconfig6 --file ~/.config/yakuakerc --group Window --key Width "100"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group yakuake --key _k_friendly_name "Yakuake"
#kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group yakuake --key toggle-window-state "Meta+\`,F12,Open/Retract Yakuake"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group yakuake --key toggle-window-state "F12,F12,Abrir/retraer Yakuake"
#killall kglobalaccel6; kglobalaccel6 > /dev/null & ; disown
# TODO: Select zsh Konsole profile

### Dolphin
kwriteconfig6 --file ~/.config/dolphinrc --group ContextMenu --key ShowCopyMoveMenu "true"
kwriteconfig6 --file ~/.config/dolphinrc --group DetailsMode --key ExpandableFolders "true"
kwriteconfig6 --file ~/.config/dolphinrc --group DetailsMode --key PreviewSize "32"
kwriteconfig6 --file ~/.config/dolphinrc --group General --key CloseActiveSplitView "true"
kwriteconfig6 --file ~/.config/dolphinrc --group General --key FilterBar "true"
kwriteconfig6 --file ~/.config/dolphinrc --group General --key RememberOpenedTabs "false"
kwriteconfig6 --file ~/.config/dolphinrc --group General --key ShowFullPath "true"
kwriteconfig6 --file ~/.config/dolphinrc --group General --key UseTabForSwitchingSplitView "true"

### KWin
# Virtual Desktops
kwriteconfig6 --file ~/.config/kwinrc --group Desktops --key Rows "1"
kwriteconfig6 --file ~/.config/kwinrc --group Desktops --key Number "1"
# Set titlebar buttons
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key BorderSize "Normal"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key BorderSizeAuto "false"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft "MNS"
#kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnLeft "MF"
#kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key ButtonsOnRight "IAX"
kwriteconfig6 --file $HOME/.config/kwinrc --group org.kde.kdecoration2 --key theme "Brisa"
#qdbus org.kde.KWin /KWin reconfigure

### GLOBAL SHORTCUTS
# Shortcuts: Meta+Up/Down to Maximize/Minimize
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window Maximize" "Meta+PgUp,Meta+PgUp,Maximizar la ventana"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Window Minimize" "Meta+PgDown,Meta+PgDown,Minimizar la ventana"
# Shortcuts: Disable Ctrl+F1 to switch to desktop 1
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Switch to Desktop 1" "Ctrl+F1,Ctrl+F1,Cambiar al escritorio 1"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Switch to Desktop 2" "Ctrl+F2,Ctrl+F2,Cambiar al escritorio 2"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Switch to Desktop 3" "Ctrl+F3,Ctrl+F3,Cambiar al escritorio 3"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Switch to Desktop 4" "Ctrl+F4,Ctrl+F4,Cambiar al escritorio 4"
# Shortcuts: Ctrl+Alt+Left/Right to switch to next/prev desktop
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Switch to Next Desktop" "Ctrl+Alt+Right,none,Cambiar al siguiente escritorio"
kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group kwin --key "Switch to Previous Desktop" "Ctrl+Alt+Left,none,Cambiar al escritorio anterior"
# Shortcuts: Restart kglobalaccel service
killall kglobalaccel5; kglobalaccel5 > /dev/null & ; disown

### Plasma
kwriteconfig6 --file ~/.config/plasmarc --group Theme --key name "breeze-dark"
kwriteconfig6 --file ~/.config/plasmarc --group Wallpapers --key usersWallpapers "$HOME/Imágenes/Plasma Hitting Earth 1440P by antechdesigns.png"
#kwriteconfig cannot write -1 :(  #i found the way, needs an empty space...
kwriteconfig6 --file $HOME/.config/plasmarc --group PlasmaToolTips --key Delay " -1"

### Baloo (Search / File Indexer)
#balooctl disable
#balooctl purge


### MLocate (locate File Search)
# Scan for files without waiting for the scheduled service
#sudo updatedb


print_done

exit 0




