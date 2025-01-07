export EDITOR="hx"
export VISUAL="hx"

# Path
export GOPATH="$HOME/.local/share/go"
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export BUN_INSTALL="$HOME/.bun" # https://github.com/oven-sh/bun/issues/1678
export PATH="$PATH:$HOME/.local/bin:$CARGO_HOME/bin:$GOPATH/bin:$BUN_INSTALL/bin"

# Paste contents of find in series (-s) with delimiter (-d) ":"
export KUBECONFIG=$(find "$HOME/.kube" -type f -name "*.yaml" | paste -sd ":")

# Random
export GHCUP_USE_XDG_DIRS="non-empty"
export STACK_XDG="non-empty"
export PGHOST="localhost"
export KEYTIMEOUT=1
export QMK_HOME="$HOME/.local/share/qmk_firmware"
