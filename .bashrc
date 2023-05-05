#!/usr/bin/bash

[ "$TERM" = "xterm-kitty" ] && alias ssh="TERM=xterm-256color ssh"

function cmd_exists() {
	which "$1" &>/dev/null
}

if cmd_exists lsd; then
	alias ls='lsd'
	alias ll='lsd --oneline'
	alias lt='lsd --tree'
fi

if cmd_exists xdg-open; then
	alias open="xdg-open"
fi

viewcert() {
	openssl x509 -in "$1" -noout -text
}

# Prompt
source "/usr/share/git/git-prompt.sh"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1

__txtboldred="\e[1;31m"
__txtboldgreen="\e[1;32m"
__txtcyan="\e[0;36m"
__txtsilver="\e[0;37m"

__txtreset="\e[0m"

__curdir="${__txtcyan}\W${__txtreset}"

function __exitstate {
	if [ $? -eq 0 ]; then
		echo -ne "${__txtboldgreen}>${__txtreset}"
	else
		echo -ne "${__txtboldred}>${__txtreset}"
	fi
}

PS1="${__curdir}\$(__git_ps1 ' ${__txtsilver}%s${__txtreset}') \$(__exitstate) "
