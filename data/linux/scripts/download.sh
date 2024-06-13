#!/bin/sh
sleep 0.2
xdotool key ctrl+l ctrl+c
url=$(xclip -o)
exists=0
while read LINE
do
	if [ $LINE = $url ]
	then
		exists=1
		break
	fi
done < ~/data/Music/registry
if [ $exists == 0 ]
then
	echo $url >> ~/data/Music/registry
	notify-send -t 1000 "Downloading: "$url
	xdotool key Tab
	youtube-dl -f bestaudio $url -o "~/data/Music/%(title)s.%(ext)s" -q
else
	notify-send -t 1000 "Song already downloaded."
	xdotool key Tab
fi
