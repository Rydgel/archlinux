#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#
# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi
export OOO_FORCE_DESKTOP=gnome &
# exec startkde
# exec startxfce4
xrandr --output default --mode 1440x900 --pos 0x0 &
numlockx on &
#devilspie &
#xcompmgr &
wmname LG3D &
#xscreensaver -no-splash &
#thunar --daemon &
wicd-client &
# volwheel &
# nm-applet --sm-disable &
# (sleep 30 && conky -c conky/.conkyrc) &
# xcompmgr -c -t-5 -l-5 -r4.2 -o.55 &
# xcompmgr -Cc -o 1.00 -r 9 &
# exec openbox-session
# xmonad
# exec evilwm -display :1 -term urxvt
# exec pekwm
exec gnome-session
# exec openbox-session
# awesome
# exec start-fusion.sh
# exec startkde
