#!/usr/bin/env bash

xsetroot -cursor_name left_ptr &
feh --bg-scale $HOME/Pictures/houses.jpg &
urxvt &
exec $HOME/.bin/frankenwm2bar2.sh
