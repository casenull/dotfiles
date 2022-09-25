#!/usr/bin/zsh

# Editor/Visual #
export EDITOR="nvim"
export VISUAL="nvim"

# kitty ssh #
# https://sw.kovidgoyal.net/kitty/kittens/ssh/
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

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

# History #
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt SHARE_HISTORY
setopt hist_ignore_space

# Keybindings #
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "\e[3~" delete-char

# Completion #
autoload -U compinit && compinit

# Prompt #
PROMPT='%B%F{green}%n@%m%f:%F{blue}%~%f$%b '

# Envvars #
# psql: connect to localhost by default
export PGHOST="localhost"
