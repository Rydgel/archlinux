#!/bin/bash

export MPD_HOST=127.0.0.1

is_playing_music=$(mpc | grep -e ^\\[p[al][ua][sy][ei].*\\])

echo "$is_playing_music" | grep -qe ^\\[paused\\] && echo "paused" > /tmp/mpd.tmp && exit

if [ ! -n "$is_playing_music" ]; then
  [ -f /tmp/mpd.tmp ] && rm -r /tmp/mpd.tmp && exit
else
  disp=`mpc --format "%artist% ## %title%" | head -1`
  if [ ${#disp} -gt 80 ]; then
    echo "${disp:0:77}..." > /tmp/mpd.tmp
  else
    echo "${disp}" > /tmp/mpd.tmp
  fi
fi
