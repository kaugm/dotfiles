

# Prompts
PS1='%~ ➜ '


# Aliases

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .....='cd ../../../../..'

alias la='ls -a'
alias ll='ls -l'
lp () {
	ls -lAp | awk '{print $1, $9}'
}
lt () {
	ls -lAp | awk '{print $6, $7, $8, $9}'
}

alias size='du -h | grep -v "./\\."'

alias x='exit'
alias c='clear'

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
		cluster) while true; do
			aws eks describe-cluster --name $2 --query cluster.status
			sleep 10
		done 
		echo "Cluster created" ;;
		*) echo "usage: status [ cluster ] [ cluster name ]" ;;
	esac

}
