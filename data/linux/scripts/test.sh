#!/bin/sh
# gets called from "/etc/udev/rules.d/usb.rules" when mouse gets plugged in
# use this to reload
# udevadm control --reload
if [ -e /tmp/usb_mouse_lock ]
then
	notify-send "lockfile exists"
	exit
else
	touch /tmp/usb_mouse_lock
	id=$(pidof xscreensaver)
	if [ "$id" ];then
		notify-send "exists"
		pkill $id
	else
		notify-send "starting"
		xscreensaver | tee >> /tmp/stdout.log
	fi
	sleep 5
	rm /tmp/usb_mouse_lock
fi
echo "usb run" >> /tmp/usb


