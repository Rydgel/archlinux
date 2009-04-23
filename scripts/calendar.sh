#! /bin/sh
#str=`echo '\033[01;32m29'`

DATE=`date | awk -F" " '{print $3}'`

case "$1" in
first_part)
cal | grep '[a-zA-Z]';
cal | grep -v '[a-zA-Z]' | grep '[0-9]' | awk -F$DATE ' BEGIN {i=0}
($1 == $0 && i==0) {print $1}
($1 != $0 && i==0){i=i+1;print $1}';
;;
today)
echo $DATE;
;;
second_part)
cal | grep -v '[a-zA-Z]' | grep '[0-9]' | awk -F$DATE ' BEGIN {i=1}
(i==0) {print $0}
($1 != $0 && i==1){i=i-1;print $2}';
;;
esac
