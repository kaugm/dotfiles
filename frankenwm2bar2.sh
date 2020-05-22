#!/usr/bin/env bash


wm="frankenwm"
ff="/tmp/frankenwm.fifo"
[[ -p $ff ]] || mkfifo -m 600 "$ff"

source ~/.cache/wal/colors.sh
bgcolor=$color0
fgcolor=$color7


# desktop names
ds=("Home" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X")

# layout names
ms=("TILE" "[M]" "[B]" "[G]" "[F]" "[D]" "EQUAL")

while read -t 60 -r wmout || true; do
    if [[ $wmout =~ ^(([[:digit:]]+:)+[[:digit:]]+ ?)+$ ]]; then
        read -ra desktops <<< "$wmout" && unset r
        for desktop in "${desktops[@]}"; do
            IFS=':' read -r d w m c u <<< "$desktop"
            ((c)) &&  mode="${ms[$m]}"
            ((c)) && workspace="${ds[$d]}"
        done
    fi
    printf "%s%s%s\n" "%{l}%{B$fgcolor}%{F$bgcolor}   $workspace   %{B-}%{F-}" "%{r}%{B$fgcolor}%{F$bgcolor}   $mode   $(date +"%d %b %H:%M")   %{B-}%{F-}"
    sleep 1
done < "$ff" | lemonbar -p -d -g 2560x42 -u 2 -B "#000000" -F "#eeeeee" \
-f "Ubuntu:size=9" &

# pass output to fifo
"$wm" > "$ff"
