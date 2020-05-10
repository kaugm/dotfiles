#!/usr/bin/env bash
## LOCATION: $HOME/.bin/

### Options ###
poweroff="poweroff"
reboot="reboot"
lock="lock"
# Variable passed to rofi
options="$poweroff\n$reboot\n$lock"

uptime=$(uptime -p | sed -e 's/up //g')

chosen="$(echo -e "$options" | rofi -p "You've been working for $uptime" -dmenu -padding 500)"
case $chosen in
    $poweroff)
#        systemctl poweroff
		sudo shutdown now
        ;;
    $reboot)
#        systemctl reboot
		sudo shutdown -r now
        ;;
    $lock)
        /usr/lib/xscreensaver/gluqlo -f
        ;;
esac


