#!/bin/sh

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

DESKTOP_ENV=""
if which /usr/lib/openbox/xdg-autostart >/dev/null; then
  /usr/lib/openbox/xdg-autostart $DESKTOP_ENV
fi

export OOO_FORCE_DESKTOP=gnome &
nitrogen --restore &
#pypanel &
tint2 &
#stalonetray &
(sleep 10 && trayer --edge top --align right --widthtype pixel --width 200 --heighttype pixel --height 19 --SetDockType true --transparent true --alpha 255 --tint 000) &
