selected=$(echo -e "Extend\nMain Monitor\nSecondary Monitor" | rofi -dmenu) 

if [ "$selected" = "Extend" ]
then
	xrandr --output LVDS1 --mode 1600x900 --pos 1680x150 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off --output VGA1 --primary --mode 1680x1050 --pos 0x0 --rotate normal --output VIRTUAL1 --off
	qtile-cmd -o cmd -f restart
elif [ "$selected" = "Main Monitor" ]
then
	xrandr --output LVDS1 --primary --mode 1600x900 --pos 43x0 --rotate normal --output DP1 --off --output DP2 --off --output DP3 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off --output VGA1 --off --output VIRTUAL1 --off
elif [ "$selected" = "Secondary Monitor" ]
then
	xrandr --output LVDS1 --off --output DP1 --off --output DP2 --off --output DP3 --off --output HDMI1 --off --output HDMI2 --off --output HDMI3 --off --output VGA1 --mode 1680x1050 --pos 0x0 --rotate normal --output VIRTUAL1 --off
	qtile-cmd -o cmd -f restart
else
	echo "Wrong selection"
fi
