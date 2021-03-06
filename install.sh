#!/usr/bin/env bash

apps="git vim rxvt-unicode xinit xsetroot hsetroot x11-xserver-utils build-essential x11proto-core-dev libx11-xcb-dev libxcb-util-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-ewmh-dev libxft-dev libimlib2-dev xorg-xinit firefox curl conky conky-all gimp scrot lxappearance xrdp ranger python3-pip feh xsel nodejs"

repos=("https://www.github.com/kaugm/dotfiles" "https://www.github.com/kaugm/mmwm" "https://www.github.com/kaugm/xmenu" "https://www.github.com/vinceliuice/Qogir-theme" "https://www.github.com/horst3180/vertex-icons" "https://www.github.com/drscream/lemonbar-xft" "https://www.github.com/start/siji")

# Install packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install $apps

# Clone Github repos for compiling
for repo in repos; do
	git clone $repo
	echo "Cloning $repo..."
done

# Install python packages
pip3 install selenium
pip3 install pandas
pip3 install requests
pip3 install bs4
pip3 install lxml
pip3 install pynput

# Install node packages
npm install -g create-react-app
npm install react-icons --save

# Initialize system by copying dotfiles to proper directories
chmod u+x dotfiles/system
dotfiles/system init

#This section creates a .desktop file for executing the Xsession
echo "[Desktop Entry]
Name=Xsession
Exec/etc/X11/Xsession" > /usr/share/xsessions/custom.desktop

ln -s $HOME/.xinitrc $HOME/.xsession

# Personalize system
mkdir -p $HOME/dev
mkdir -p $HOME/.themes
mkdir -p $HOME/.icons
rm -r $HOME/Templates $HOME/Videos
