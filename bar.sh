#!/usr/bin/env bash

fgcolor=#eeeeee

while true; do

net() {
	ssid=$(iwgetid | cut -d '"' -f2)
	if : >/dev/tcp/8.8.8.8/53; then
		printf "\ue222 $ssid"
	else
		printf "\ue21f Disconnected"
	fi
}

vol() {
	current=$(amixer -D pulse get Master | awk -F 'Left:|[][]' 'BEGIN {RS=""}{ print $3 }')
	echo "$current"
	}
vol_icon() {
	printf "\ue050"
}

win() {
	title=$(xdotool getactivewindow getwindowname)
	case $title in
		*"karl@ares"*) term=$(echo $title | sed 's/^[^:]*://g')
			echo "Terminal $term" ;;
		*"Mozilla Firefox"*) echo "Mozilla Firefox" ;;
		*) echo $title ;;
	esac
	
}

mem() {
	used=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
	echo "$used%"
}
mem_icon() {
	printf "\ue021"
}

proc() {
	if [[ $(prep npm) ]]; then
		printf "\ue13d" "\ue14a" "\ue13e"
	fi
}


	printf "%s%s%s\n" "   $(win)    %{r}$(proc)   $(mem_icon) $(mem)   $(vol_icon) $(vol)   $(net)   $(date +"%d %b %H:%M")   %{B-}%{F-}"
	sleep 5
	done < "$HOME/.cache/bar.fifo" | lemonbar -p -d -g 2560x30 -f "Ubuntu Mono:size=10" -f '-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1' -B "#000000" -F "#eeeeee" &


# If bar is not starting, has the FIFO been made?
# Below to kickstart the FIFO
echo "start" > $HOME/.cache/bar.fifo

