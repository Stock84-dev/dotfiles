#!/bin/bash

FILE=/tmp/clion_file_pick

alacritty -e ranger --choosefile=$FILE $(dirname $1)
sleep 0.1
xdotool key --delay 1 "colon" "e" "space" 
xdotool key --delay 0 $(cat $FILE | sed 's/./& /g' | sed 's/\//slash/g' | sed 's/_/underscore/g' | sed 's/\./period/g' | sed 's/-/minus/g') "Enter"
