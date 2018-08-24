# Path to your oh-my-zsh installation.
export ZSH=/home/avanier/.oh-my-zsh

ZSH_THEME="ax"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git chef kitchen knife vagrant git-open rbenv ax-aliases)

export LANG=en_US.UTF-8

export EDITOR="emacs -nw"

export GOPATH="$HOME/src/gopath"
export GOBIN="$GOPATH/bin"
export GB="$GOBIN"

alias emacs='emacs -nw'
alias clock="tty-clock -c -C 1 -n -f '%A, %B %d %Y'"
alias cmatrix="cmatrix -abs -u 9 -C yellow"
alias pass="gopass"
alias ssh="TERM=xterm-256color ssh"

alias kc="kitchen converge"
alias kd="kitchen destroy"
alias kl="kitchen login"
alias kv="kitchen verify"
alias kdc="kitchen destroy && kitchen converge"

alias kda="vagrant global-status --prune"

alias lzh="source ~/.zshrc"
alias ezh="${EDITOR} ~/.zshrc"

alias ei3="emacs -nw ~/.config/i3/config"

alias genpw="docker run --rm -it avanier/hsxkpasswd-alpine"

function list_vms {
	VBoxManage list vms | awk '{print $1}'
}
function stop_vms {
	VBoxManage list vms | awk '{print $2}' | xargs -I {} VBoxManage controlvm {} poweroff
}
function prune_vms {
	VBoxManage list vms | awk '{print $2}' | xargs -I {} VBoxManage unregistervm {} --delete
}

alias be='bundle exec'

function rinit() {
  DEST=${1:-README.md}
  echo "Initializing ${DEST}"
  curl -s https://gist.githubusercontent.com/zenorocha/4526327/raw/5b41e986a8ac81cf97f53cb2015f07b21c0795b9/README.md > ${DEST}
}

export VAULT_ADDR="https://vault.amonoid.io:8200"

function vault-login() {
    vault login -method=github token="$(cat ~/.github_token)"
}

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

source $ZSH/oh-my-zsh.sh
nvm() {
    unset -f nvm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm "$@"
}
 
node() {
    unset -f node
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    node "$@"
}
 
npm() {
    unset -f npm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    npm "$@"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

source <(gopass completion zsh | head -n -1 | tail -n +2)
compdef _gopass gopass
compdef _gopass pass

source <(kubectl completion zsh)
compdef _kubectl kubectl

# Adds yarn global bins to path
export PATH="$(yarn global bin):$PATH"

# Erlang and Elixir stuff
test -f /opt/erlang/activate && . /opt/erlang/activate
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# zprof # uncomment to profile
