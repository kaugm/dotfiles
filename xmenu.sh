#!/bin/sh

desknum=$(xprop -root | grep "_NET_CURRENT_DESKTOP(CARDINAL)" | grep -o '[0-9]\+' | awk '{print ($1 = $1 + 1)}')

cat <<EOF | xmenu | sh &
Applications
	Firefox	firefox
	Gimp	gimp
	Image Viewer	sxiv -t -b $HOME/Pictures/*
	Notepad		mousepad
	IDE		code
Terminal	urxvt
Notify
	COVID	$HOME/bin/notify covid
	Weather		$HOME/bin/notify weather
	Date	$HOME/bin/notify date
	Desktop		notify-send "Current Desktop: $desknum"
Places
	Ranger		urxvt -e ranger
	home	thunar ~
	bin		thunar ~/bin
	dev
		macro-counter		thunar ~/dev/macro-counter
		paomejiab.github.io		thunar ~/dev/paomejiab.github.io
		portfolio_website		thunar ~/dev/portfolio_website
	Downloads	thunar ~/Downloads
	Pictures	thunar ~/Pictures
Development
	macro-counter 	npm start $HOME/dev/macro-counter/
System
	Volume
		-10%	$HOME/bin/vol.sh d
		+10%	$HOME/bin/vol.sh u
		Set 0%		$HOME/bin/vol.sh d 0%
		Set 25%		$HOME/bin/vol.sh s 25%
		Set 50%		$HOME/bin/vol.sh s 50%
		Set 75%		$HOME/bin/vol.sh s 75%
		Set 100%	$HOME/bin/vol.sh s 100%
	Connect
		Wifi		$HOME/bin/wifi.sh ecuafi
		SSH Samba		urxvt -e ssh pi@192.168.1.250
	Color Picker	xmcp | xsel -b
	Backup		$HOME/bin/system backup
	Copy to share		urxvt -e scp -r $HOME/dotfiles pi@192.168.1.250:/Shared/Backup/main/
	lxappearance	lxappearance
	Screenshot		scrot -d 5
	New dark theme		$HOME/bin/colors2 d
	New light theme		$HOME/bin/colors2 l
EOF
