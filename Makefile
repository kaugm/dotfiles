PREFIX ?= $(HOME)

define clone
    git clone https://github.com/$1/$2 && cd $2 && make && sudo make install
endef

all:
	@echo Run \'make install\' to install all necessary programs. Please ensure git is installed.

install:

	sudo apt-get update

	$(call clone,dylanaraps,sowm)

