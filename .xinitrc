#!/usr/bin/env bash

xsetroot -cursor_name left_ptr &
feh --bg-scale $HOME/Pictures/bear.jpg &
urxvt &
exec $HOME/.bin/mmwmbar.sh
