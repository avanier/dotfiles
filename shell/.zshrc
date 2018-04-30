# Path to your oh-my-zsh installation.
export ZSH=/home/avanier/.oh-my-zsh

ZSH_THEME="ax"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git elixir chef kitchen knife pass vagrant git-open rbenv kubectl gopass ax-aliases)

export LANG=en_US.UTF-8

export EDITOR="emacs -nw"
export GOPATH="$HOME/src/gopath"
export GOBIN="$GOPATH/bin"
export GB="$GOBIN"

export CONCOURSE_EXTERNAL_URL=http://$(ip addr show wlp6s0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1):9543

source <(kubectl completion zsh)


alias emacs='emacs -nw'
alias clock="tty-clock -c -C 1 -n -f '%A, %B %d %Y'"
alias cmatrix="cmatrix -abs -u 9 -C yellow"

alias kc="kitchen converge"
alias kd="kitchen destroy"
alias kl="kitchen login"
alias kv="kitchen verify"
alias kdc="kitchen destroy && kitchen converge"

alias kda="vagrant global-status --prune"

alias lzh="source ~/.zshrc"
alias ezh="emacs -nw ~/.zshrc"

alias ei3="emacs -nw ~/.config/i3/config"

alias genpw="docker --rm -it avanier/hsxkpasswd-alpine"

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

export VAULT_ADDR="http://vault.amonoid.io:8200"

function vault-login() {
    vault login -method=github token="$(cat ~/.github_token)"
}

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

source $ZSH/oh-my-zsh.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then source '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then source '/opt/google-cloud-sdk/completion.zsh.inc'; fi

# Adds yarn global bins to path
export PATH="$(yarn global bin):$PATH"
