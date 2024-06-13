#!/bin/sh
#scrot -s ~/data/Pictures/screenshots/$(date +%d.%m.%y-%H:%M:%S).png && notify-send -t 1000 "Screenshot saved."
status=""
if [ $1 = a ]
then
	status=`escrotum ~/data/Pictures/screenshots/$(date +%d.%m.%y-%H:%M:%S).png`
elif [ $1 = A ]
then
	status=`escrotum -C`
elif [ $1 = s ]
then
	status=`escrotum -s ~/data/Pictures/screenshots/$(date +%d.%m.%y-%H:%M:%S).png`
elif [ $1 = S ]
then
	status=`escrotum -s -C`
elif [ $1 = n ]
then
	escrotum -s ~/data/Documents/Documents/School/college/semester2/web/predavanja/notes/$(date +%d.%m.%y-%H:%M:%S).png
fi
# if user canceled selection we don't send notification
# exits with 1 if launched from sxhkd but still creates screenshot
[[ $status = *"Canceled"* ]] && exit || ([ $? -eq 0 ] || [ $? -eq 1 ]) && notify-send -t 1000 "Screenshot saved." || notify-send -t 1000 "Error occured!"
