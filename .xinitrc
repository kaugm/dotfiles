#!/usr/bin/env bash

xsetroot -cursor_name left_ptr &
#hsetroot -solid "#aec4e8" &
#hsetroot -solid "#BDCABF" &
conky &
hsetroot -solid $(cat $HOME/.cache/rpg/colors | grep color8 | cut -d '"' -f2) &
# urxvt &
exec mmwm
