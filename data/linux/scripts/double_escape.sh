#!/bin/sh
# turning off sxhkd to prevent recursive behaviour
pkill -USR2 -x sxhkd
xdotool key Escape
xdotool key Escape
pkill -USR2 -x sxhkd
