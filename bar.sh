#!/usr/bin/env bash

# Get background color variable, $color0
source $HOME/.cache/rpg/colors

fgcolor=#eeeeee

while true; do

net() {
	if : >/dev/tcp/8.8.8.8/53; then
		echo "Connected"
	else
		echo "Disconnected"
	fi
}

vol() {
	amixer -D pulse get Master | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ print $3 }'
}

	printf "%s%s%s\n" "%{r}   $(vol)  $(net)   $(date +"%d %b %H:%M")   %{B-}%{F-}"
	sleep 5
	done < "$HOME/.cache/bar.fifo" | lemonbar -p -d -g 240x30+10+10 -f "Ubuntu Mono:size=9" -B "$color0" -F "#eeeeee" &


# If bar is not starting, has the FIFO been made?
# Below to kickstart the FIFO
echo "start" > $HOME/.cache/bar.fifo

