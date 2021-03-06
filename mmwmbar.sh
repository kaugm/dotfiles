#!/usr/bin/env bash


wm="mmwm"
ff="/tmp/mmwm.fifo"
[[ -p $ff ]] || mkfifo -m 600 "$ff"

bgcolor=#000000
fgcolor=#eeeeee


# desktop names
ds=("Home" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X")

# layout names
ms=("TILE" "EQUAL")

while read -t 60 -r wmout || true; do
    if [[ $wmout =~ ^(([[:digit:]]+:)+[[:digit:]]+ ?)+$ ]]; then
        read -ra desktops <<< "$wmout" && unset r
        for desktop in "${desktops[@]}"; do
            IFS=':' read -r d w m c u <<< "$desktop"
            ((c)) &&  mode="${ms[$m]}"
            ((c)) && workspace="${ds[$d]}"
        done
    fi
    printf "%s%s%s\n" "%{l}    $workspace    %{B-}%{F-}" "%{r}   $mode   $(date +"%d %b %H:%M")   %{B-}%{F-}"
done < "$ff" | lemonbar -p -d -g 2560x30 -u 2 -B "#000000" -F "#eeeeee" \
-o 1 -f "Ubuntu:size=9" &

# pass output to fifo
"$wm" > "$ff"
