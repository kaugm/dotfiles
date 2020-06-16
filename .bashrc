# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# other prompt characters: ➜››
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\w  ➜\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Alias
# Directory stuff
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias x='exit'
alias c='clear'

# List files
alias ls='ls --color -hF --group-directories-first'
alias la='ls --color -A -hF --group-directories-first'
#alias lp='ls --color -Ao --group-directories-first'
lp () {
	ls -lAp | awk '{print $1, $9}'
}
lt () {
	ls -lAp | awk '{print $6, $7, $8, $9}'
}

mod() {
	case $1 in
	bash) vim ~/.bashrc 
		  source ~/.bashrc
		  clear ;;
	xres) vim ~/.Xresources
		  xrdb ~/.Xresources
		  clear ;;
	*) echo "[ bash / xres ]"
	esac
}


# Change permissions
allow() {
	case $1 in
	rw) chmod u+rw $2 ;;
	x) chmod u+x $2 ;;
	*) echo "[rw / x] [file]" ;;
	esac
}

# Theme related commands
alias theme='~/.bin/color'

create() {
	touch -- "$1" &&
	chmod u+x -- "$1" &&
	echo "#!/usr/bin/env bash" >> "$1" &&
	vim -- "$1"
}

extract() {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

search() {
	case $1 in
	file) find -name $2 ;;
	dir) 	c=1
	local dir=($(find / -type d -name $2 2>&1 | grep -v "Permission denied\|Invalied argument"))
	if [ $(find / -type d -name $2 2>&1 | grep -v "Permission denied\|Invalied argument" | wc -l) -gt 1 ]; then
		for item in ${dir[@]}; do
			echo "$c. $item"
			((c++))
		done
		read g
		((g--))
		cd ${dir[g]}
	else
		cd ${dir}
	fi ;;
	history) history | grep $2 ;;
	proc) ps aux | grep $2 ;;
	pkg) apt-cache search $2 ;;
	str)
		FILES=($(find -type f))
		for FILE in ${FILES[@]}; do
			if [[ $(cat $FILE | grep "$2") ]]; then
				echo $FILE
			fi
		done ;;

	*) echo "search [file / dir / history / proc / pkg / str] [name*]" ;;
	esac
}

open() {
case $(file $1 | awk '{print $2}') in
	ASCII|POSIX|UTF-8|Python|HTML|Bourne-Again) vim $1 ;;
	PNG|JPG|JPEG) sxiv $1 ;;
	*) echo "add program to open $(file $1 | awk '{print $2}') filetypes"
esac
}

system() {
	case $1 in
		backup) $HOME/.bin/system backup ;;
		restore) $HOME/.bin/system restore ;;
		*) echo " [backup / restore]" ;;
	esac
}

gclo() {
	if [ $# -lt 2 ]; then
		printf '%s\n' "Usage: gclo [username] [repository]"
		exit 1
	fi
	git clone https://github.com/"$1"/"$2" &&
	cd  "$2"
}

pkg() {
	case $1 in
		install) sudo apt install $2 -y ;;
		remove) sudo apt purge $2 -y ;;
		clean) sudo apt autoremove ;;
		*) echo "[ install / remove / clean ]" ;;
	esac
}

dl() {
	[[ -z "$2" ]] || echo "Usage: dl [FILE] [URL]"
	wget -O $1 $2
}



# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#Adding the path for wal [not necessary on fresh installs?]
export PATH="$HOME/.local/bin:$PATH"
