function exists() {
	command -v $1 >/dev/null 2>&1
}

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

setopt interactive_comments        # allow comments in prompt
setopt no_nomatch                  # pass unmatched globs through
setopt bash_auto_list no_auto_menu # tab completes, second tab lists, no menu cycling

# Aliases
if exists lsd; then
	alias lsd="lsd --date +'%F %T'"
	alias ls="lsd"
	alias ll="lsd --oneline"
	alias lt="lsd --tree"
fi

alias grep="grep --color=auto"

# Keybindings
bindkey -s ^f "~/.local/bin/tmux-sessionizer\n" # POWER FINGER

# Integrations
if exists mise; then
	eval "$(mise activate zsh)"
fi

# Completion
fpath=(~/.local/share/zsh/site-functions $fpath)
autoload -U compinit
compinit

if exists fzf; then
	source <(fzf --zsh)
fi

if exists oh-my-posh; then
	# --strict because oh-my-posh is installed via mise
	eval "$(oh-my-posh init zsh --strict --config ~/.config/oh-my-posh/curse.toml)"
fi
