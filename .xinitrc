#!/usr/bin/env bash

xset +fp /home/karl/.fonts
xset fp rehash

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
