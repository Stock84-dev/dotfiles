#!/bin/sh
# screensaver that prints my vim calendar and countdowns to specific date
# uses xscreensaver with phosphor 
# phosphor -root -scale 2 -geom =1280x1024 -delay 10000 -program '~/data/linux/scripts/screensaver.sh'
vim -u "~/data/linux/scripts/screensaver.vimrc" -c ":Calendar" -c ":set t_te=" -c "call timer_start(200, 'ExitFile')"
# sleeping because it takes time to draw calendar and it doesn't look good when it is 
# refreshing countdown faster than 1 sec (to catch up)
sleep 32
while :
do
	tput cup 1 11
	current=`date +%s`
	target=`date -d 1/1/2021 +%s`
	dif=$target-$current
	echo -n "$((dif/86400)) days $(((dif/3600)%24)) hours $(((dif/60)%60)) minutes $((dif%60)) seconds"
	sleep 1
done
