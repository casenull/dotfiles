# zmodload zsh/zprof

# Install Zinit, a flexible and fast zsh plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Install oh-my-posh
zinit ice as"program" from"github-rel" mv"posh-* -> oh-my-posh"
zinit light JanDeDobbeleer/oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/curse.toml)"

# Manual Completion:
# kubectl completion zsh > ~/.local/share/zsh/zfunc/_kubectl
# cilium completion zsh > ~/.local/share/zsh/zfunc/_cilium
# hubble completion zsh > ~/.local/share/zsh/zfunc/_hubble
# talosctl completion zsh > ~/.local/share/zsh/zfunc/_talosctl
fpath=(~/.local/share/zsh/zfunc $fpath)

# Wicked fast plugin loading
# https://zdharma-continuum.github.io/zinit/wiki/Example-Minimal-Setup/
zinit wait lucid light-mode for \
	atinit"zicompinit; zicdreplay" \
	zsh-users/zsh-syntax-highlighting \
	atload"_zsh_autosuggest_start; bindkey "^y" autosuggest-accept" \
	zsh-users/zsh-autosuggestions \
	blockf atpull"zinit creinstall -q ." \
	zsh-users/zsh-completions

# Keybindings
bindkey -v
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Disable underlines in syntax highlighting
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green
# for key val in "${(@kv)ZSH_HIGHLIGHT_STYLES}"; do
#   echo "$key -> $val" | grep underline
# done

# Aliases
function exists() {
	command -v $1 >/dev/null 2>&1
}

if exists lsd; then
	alias lsd="lsd --date +'%F %T'"
	alias ls='lsd'
	alias ll='lsd --oneline'
	alias lt='lsd --tree'
fi

alias grep="grep --color=auto"

# Integrations
if exists fzf; then
	eval "$(fzf --zsh)"
fi

# zprof
