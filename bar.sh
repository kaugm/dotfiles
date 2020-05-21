#!/usr/bin/env bash

covid=$(curl https://corona-stats.online/states/US?format\=json | python3 -c 'import sys,json;data=json.load(sys.stdin)["data"][17];print("NC[" + str(data["active"]) + "] +" + str(data["todayCases"]))')

date=$(date "+%H:%M")
mem=$(free -h | grep Mem | awk '{print $3}')


while true; do
	echo "%{l}   $covid %{r} $mem  $date   " | lemonbar -p -g 2560x36 -B "#111111" -F "#eeeeee" -f Iosevka:12
	sleep 60
done

