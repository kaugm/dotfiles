autoload -Uz compinit
compinit

# Prompts
PS1='%3~ ➜ '


# Aliases

# DevOps Tools
alias tf='terraform'
alias k='kubectl'
alias e='eksctl'

watch() {
	case $1 in
		pods) k get pods --watch ;;
		nodes) k get nodes --watch ;;
	esac
}

alias filter='~/bin/filter.py'

# Directory Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .....='cd ../../../../..'

# Viewing Files
alias la='ls -a'
alias ll='ls -GFhal'
lp () {
	ls -lAp | awk '{print $1, $9}'
}
lt () {
	ls -lAp | awk '{print $6, $7, $8, $9}'
}

# Misc
alias cls='clear && ls'
alias cla='clear && la'

alias size='du -h | grep -v "./\\."'

alias x='exit'
alias c='clear'

alias h='history'
alias he='cat ~/.zsh_eternal_history | perl -e "while (<>) { s/.{16}//; print $_ }" | uniq'

alias python3='clear && python3'


# Advanced Functions
search() {
	case $1 in
		file) count=1
		local files=($(find . -name $2))
		if [ ${#files[@]} -gt 1 ]; then
			for file in ${files[@]}; do
				echo "$count. $file"
				((count++))
			done
			echo "Navigate to file directory by number? "
			read choice
			cd $(dirname ${files[$choice]})
			ls
		else
			cd $(dirname ${files[1]})
			ls
		fi ;;
		dir) count=1
		local dirs=($(find . -type d -name $2 | sort -t '\0' -n 2>&1))
		if [ ${#dirs[@]} -gt 1 ]; then
			for dir in ${dirs[@]}; do
				echo "$count. $dir"
				((count++))
			done
			echo "Navigate to directory by number? "
			read choice
			cd ${dirs[$choice]}
		else
			cd ${dirs[1]}
	
		fi ;;
		proc) ps aux | grep $2 ;;
		*) echo "usage: search [ file | dir | proc ] [ argument ]"
	esac


}

create() {
	touch -- "$1" &&
	chmod u+x -- "$1" &&
	echo "#!/usr/bin/env bash" >> "$1" &&
	vim -- "$1"
}

mkcd ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

clone() {
	if [ $# -lt 2 ]; then
		printf '%s\n' "Usage: clone [username] [repository]"
		exit 1
	fi
	git clone https://github.com/"$1"/"$2" &&
	cd  "$2"
}

# Helps with Docker issue on Apple M1 chips
docker() {
 if [[ `uname -m` == "arm64" ]] && [[ "$1" == "run" || "$1" == "build" ]]; then
    /usr/local/bin/docker "$1" --platform linux/amd64 "${@:2}"
  else
     /usr/local/bin/docker "$@"
  fi
}


status() {
	case $1 in
		cluster) 
			while true; do
				aws eks describe-cluster --name $2 --query cluster.status
				sleep 10
			done  ;;
		*) echo "usage: status [ cluster ] [ cluster name ]" ;;
	esac

}


# History Augmentations
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export HISTFILESIZE=1000000

setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "

setopt EXTENDED_HISTORY


# kubectl Autocompletion
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)
