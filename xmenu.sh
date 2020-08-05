#!/bin/sh

desknum=$(xprop -root | grep "_NET_CURRENT_DESKTOP(CARDINAL)" | grep -o '[0-9]\+' | awk '{print ($1 = $1 + 1)}')

cat <<EOF | xmenu | sh &

Run		rofi -show run
Applications
	Firefox	firefox
	Gimp	gimp
	Image Viewer	sxiv -t -b $HOME/Pictures/*
	Notepad		mousepad
	IDE		code
Terminal	urxvt
Notify
	COVID	$HOME/.bin/notify covid
	Weather		$HOME/.bin/notify weather
	Date	$HOME/.bin/notify date
	Desktop		notify-send "Current Desktop: $desknum"
Places
	Ranger		urxvt -e ranger
	home	thunar ~
	.bin	thunar ~/.bin
	Downloads	thunar ~/Downloads
	Pictures	thunar ~/Pictures
System
	Backup		$HOME/.bin/system backup
	Copy to share		urxvt -e scp -r $HOME/dotfiles pi@192.168.1.250:/Shared/Backup/main/
	SSH Samba		urxvt -e ssh pi@192.168.1.250
	Color Picker	$HOME/.bin/cselect
	New dark theme		$HOME/.bin/color new
	New light theme		$HOME/.bin/color new l
	Random theme	$HOME/.bin/color set random

EOF
