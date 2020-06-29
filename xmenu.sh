#!/bin/sh

cat <<EOF | xmenu | sh &
Run		rofi -show run
Applications
	Firefox	firefox
	Gimp	gimp
	Image Viewer	sxiv -t -b $HOME/Pictures/*
	Notepad		mousepad
	IDE		code
Terminal (urxvt)	urxvt
Notify
	COVID	$HOME/.bin/notify covid
	Weather		$HOME/.bin/notify weather
System
	Backup		$HOME/.bin/system backup
	New dark theme		$HOME/.bin/color new
	New light theme		$HOME/.bin/color new l
EOF
