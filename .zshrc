#!/usr/bin/zsh

# https://sw.kovidgoyal.net/kitty/kittens/ssh/
[ "$TERM" = "xterm-kitty" ] && alias ssh="TERM=xterm-256color ssh"

# Helpers #
cmd_exists() {
    which "$1" &>/dev/null
}

if cmd_exists lsd; then
    alias ls='lsd'
    alias ll='lsd --oneline'
    alias lt='lsd --tree'
fi

# Functions #
viewcert() {
    openssl x509 -in "$1" -noout -text
}

########## ZSH ##########

# Prompt #
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%F{blue}%s:(%f%b%F{blue})%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-shorten-color-branch

+vi-git-shorten-color-branch() {
  # Shorten branch names longer than 10 characters
	if [[ ${#hook_com[branch]} -gt 10 ]] ; then
		hook_com[branch]=${hook_com[branch]:0:7}...
	fi
	# Color branch according to state
	if git diff --quiet HEAD 2> /dev/null; then
		hook_com[branch]=%F{green}${hook_com[branch]}%f
	else
		hook_com[branch]=%F{red}${hook_com[branch]}%f
	fi
}

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
			echo "${vcs_info_msg_0_}"
  fi
}

PROMPT='%F{cyan}%c%f ' # Current directory name
PROMPT+='%(?:%B%F{green}>%b%f :%B%F{red}>%b%f )' # Arrow indicating result
RPROMPT='$(vcs_info_wrapper)' # Right side (if in a git repository): branch

# Completion #
autoload -Uz compinit && compinit

# History #
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt SHARE_HISTORY
setopt hist_ignore_space

# Keybindings #
