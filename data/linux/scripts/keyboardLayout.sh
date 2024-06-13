#!/bin/sh
sleep 0.5 &&
setxkbmap $1 &&
sleep 0.5 &&
xmodmap ~/data/linux/scripts/xmodmap &&
notify-send $1
