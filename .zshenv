export EDITOR="nvim"
export VISUAL="nvim"
export GOPATH="$HOME/.local/share/go"
export CARGO_HOME="$HOME/.local/share/cargo"
export PGHOST="localhost"
export PATH="$PATH:$HOME/.local/bin:$CARGO_HOME/bin"
export KEYTIMEOUT=1
export KUBECONFIG=""
for file in $(find $HOME/.kube/ -type f -name "*.yml" -o -name "*.yaml")
do
    export KUBECONFIG="$file:$KUBECONFIG"
done
