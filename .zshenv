#!/bin/zsh
#
# ~/.zshenv

# Exports
# export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/home/stxza/bin
typeset -U path
path=(/bin /sbin /usr/bin /usr/sbin /usr/local/bin $HOME/bin $path)

# Dircolors
eval "$(dircolors -b $HOME/.dir_colors)"

# Kill flow control
if tty -s ; then
    stty -ixon
    stty -ixoff
fi

export LC_ALL=fr_FR.UTF-8
export LC_COLLATE="C"
export LANG=fr_FR.UTF-8
export LOCALE=fr_FR.UTF-8
export LESS="-R"

# Export default pkg-config path
PKG_CONFIG_PATH="/usr/lib/pkgconfig"
export PKG_CONFIG_PATH

export EDITOR=vim
export BROWSER=firefox
export OOO_FORCE_DESKTOP=gnome

# Firefox tweak
export MOZ_DISABLE_PANGO=1

# Make framebuffer colors look like in X
#if [ "$TERM" = "linux" ]; then
#    echo -en "\e]P0222222" #black
#    echo -en "\e]P8222222" #darkgrey
#    echo -en "\e]P1803232" #darkred
#    echo -en "\e]P9982b2b" #red
#    echo -en "\e]P25b762f" #darkgreen
#    echo -en "\e]PA89b83f" #green
#    echo -en "\e]P3aa9943" #brown
#    echo -en "\e]PBefef60" #yellow
#    echo -en "\e]P4324c80" #darkblue
#    echo -en "\e]PC2b4f98" #blue
#    echo -en "\e]P5706c9a" #darkmagenta
#    echo -en "\e]PD826ab1" #magenta
#    echo -en "\e]P692b19e" #darkcyan
#    echo -en "\e]PEa1cdcd" #cyan
#    echo -en "\e]P7ffffff" #lightgrey
#    echo -en "\e]PFdedede" #white
#    clear #for background artifacting
#fi
