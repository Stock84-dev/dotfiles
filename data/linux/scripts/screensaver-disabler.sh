#!/bin/bash
#disables xscreensaver if audio is playing
while true; do
    sleep 10
    cat /proc/asound/card*/pcm*/sub*/status | grep RUNNING && xscreensaver-command -deactivate
done
