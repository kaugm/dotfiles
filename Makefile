PREFIX ?= $(HOME)

define clone
    git clone https://github.com/$1/$2 && cd $2 && make && sudo make install
endef

all:
	@echo Run \'make install\' to install all necessary programs and copy over dotfiles.

install:
	git clone https://github.com/kaugm/dotfiles
	./system init
	
	sudo apt-get update

	sudo apt-get install xinit rxvt-unicode git vim build-essential x11-utils x11-xserver-utils xorg feh libimlib2 xrdp rofi libxcb-util-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-ewmh-dev pkg-config mousepad firefox gimp thunar ranger lightdm python3.6 python3-pip htop scrot libimlib2-dev libexif-dev libxft-dev lxappearance libxcb-randr0-dev libx11-xcb-dev libxcb-xinerama0-dev notify-send dunst fonts-inconsolata
	
	pip3 install pywal

	$(call clone,kaugm,mmwm)
	$(call clone,kaugm,xmenu)
	$(call clone,kaugm,sxiv)
	$(call clone,vinceliuice,Qogir-theme)
	$(call clone,vinceliuice,Qogir-icon-theme)
	$(call clone,kaugm,drscream,lemonbar-xft)
	
	wget -O vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
	sudo apt install ./vscode.deb

