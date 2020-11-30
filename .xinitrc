#!/usr/bin/env bash

XNOTIFY_FIFO="$HOME/.cache/xnotify$DISPLAY.fifo"
export XNOTIFY_FIFO
rm -f $XNOTIFY_FIFO
mkfifo $XNOTIFY_FIFO
xnotify -g -15+15 0<>$XNOTIFY_FIFO &


# Others: Wallpaper, conky, & wm
xsetroot -cursor_name left_ptr &
#hsetroot -solid "#aec4e8" &
#hsetroot -solid "#BDCABF" &
#conky &
$HOME/bin/bar.sh &
hsetroot -solid $(cat $HOME/.cache/rpg/colors | grep color8 | cut -d '"' -f2) &
# urxvt &
$HOME/bin/bar.sh &
exec mmwm
