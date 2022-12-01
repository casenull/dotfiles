#!/usr/bin/zsh

# Editor/Visual #
export EDITOR="nvim"
export VISUAL="nvim"

# kitty ssh #
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

mvn-init() {
    mvn archetype:generate -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4
}

# History #
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt SHARE_HISTORY
setopt hist_ignore_space

# Keybindings #
#bindkey "^[[H" beginning-of-line
#bindkey "^[[F" end-of-line
#bindkey "\e[3~" delete-char
# vi mode
bindkey -v
# home/end (urxvt)
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
# home/end (xterm)
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# Shift=Tab (completion)
bindkey "\e[Z" reverse-menu-complete
# insert
bindkey "\e[2~" overwrite-mode
# delete
bindkey "\e[3~" delete-char
bindkey "^?" backward-delete-char
# history search with started command
bindkey "\e[A" up-line-or-search
bindkey "\e[B" down-line-or-search
# Ctrl+R
bindkey '^R' history-incremental-search-backward
# / in command mode
bindkey -M vicmd '/' history-incremental-search-backward

# Completion #
autoload -U compinit && compinit

# Prompt #
PROMPT='%B%F{green}%n@%m%f:%F{blue}%~%f$%b '
