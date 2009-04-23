#!/bin/bash
#
# pop-up calendar for dzen
#
# based on (c) 2007, by Robert Manea
# http://dzen.geekmode.org/dwiki/doku.php?id=dzen:calendar
# modified by urukrama
# 

TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`

(
echo '^bg(#272521)^fg(#DE8834)'`date +'%A %d %B %Y %n'`; echo
\
# current month, hilight header and today
cal \
    | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg(#DE8834)^bg(#272521)\1/;s/(^|[ ])($TODAY)($|[ ])/\1^bg(#DE8834)^fg(#272521)\2^fg(#6c6c6c)^bg(#272521)\3/"

# next month, hilight header
[ $MONTH -eq 12 ] && YEAR=`expr $YEAR + 1`
cal `expr \( $MONTH + 1 \) % 12` $YEAR \
    | sed -e 's/^\(.*[A-Za-z][A-Za-z]*.*\)$/^fg(#DE8834)^bg(#272521)\1/'

sleep 8
) \
    | dzen2 -fg '#786e5a' -bg '#272521' -fn '-*-fixed-*-*-*-*-12-*-*-*-*-*-*-*' -x 1255 -y 830 -w 160 -l 18 -sa c -e 'onstart=uncollapse;key_Escape=ungrabkeys,exit'
