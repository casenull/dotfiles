#!/usr/bin/bash

[ "$TERM" = "xterm-kitty" ] && alias ssh="TERM=xterm-256color ssh"

export EDITOR="hx"
export VISUAL="hx"
export GOPATH="$HOME/.local/share/go"
export CARGO_HOME="$HOME/.local/share/cargo"
export PGHOST="localhost"
export PATH="$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin"
export KEYTIMEOUT=1
export KUBECONFIG=""

if [ -d "$HOME/.kube" ]; then
	for file in $(find $HOME/.kube/ -type f -name "*.yml" -o -name "*.yaml"); do
		export KUBECONFIG="$file:$KUBECONFIG"
	done
fi
export QMK_HOME="$HOME/.local/share/qmk_firmware"

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

# History: No duplicate lines or ones starting with space, append sizes, update window
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=10000
shopt -s checkwinsize

# Prompt
source "/usr/share/git/git-prompt.sh"
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1

function set_prompt() {
	local last_exit_code=$?

	local cyan="\[\e[0;36m\]"
	local silver="\[\e[0;37m\]"
	local boldred="\[\e[1;31m\]"
	local boldgreen="\[\e[1;32m\]"
	local reset="\[\e[0m\]"

	local curdir="${cyan}\W${reset}"

	if [[ -n "$VIRTUAL_ENV" ]]; then
		local venv="${boldgreen}($(basename $VIRTUAL_ENV))${reset} "
	else
		local venv=""
	fi

	if [ $last_exit_code -ne 0 ]; then
		local statussign="${boldred}>${reset}"
	else
		local statussign="${boldgreen}>${reset}"
	fi

	local gitsign=$(__git_ps1 "${silver}%s${reset} ")

	PS1="${venv}${curdir} ${gitsign}${statussign} "
}

PROMPT_COMMAND="set_prompt"
