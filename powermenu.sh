#!/usr/bin/env bash
## LOCATION: $HOME/.bin/

### Options ###
power_off="Poweroff"
reboot="Reboot"
lock="Lock"
# Variable passed to rofi
options="$power_off\n$reboot\n$lock"

uptime=$(uptime -p | sed -e 's/up //g')

chosen="$(echo -e "$options" | rofi -p "You've been working for $uptime" -dmenu -padding 500)"
case $chosen in
    $power_off)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        /usr/lib/xscreensaver/gluqlo -f
        ;;
esac


