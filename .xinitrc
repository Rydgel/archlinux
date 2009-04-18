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
#devilspie &
#xcompmgr &
wmname LG3D &
xscreensaver -no-splash &
thunar --daemon &
volwheel &
(sleep 30 && conky -c conky/.conkyrc) &
# xcompmgr -c -t-5 -l-5 -r4.2 -o.55 &
# exec openbox-session
# xmonad
# exec pekwm
# exec gnome-session
# exec openbox-session
awesome
# exec start-fusion.sh
