# Source Zplug

if [[ -s "/usr/local/opt/zplug" ]]; then
    export ZPLUG_HOME=/usr/local/opt/zplug
elif [[ -s "/home/linuxbrew/.linuxbrew/opt/zplug" ]]; then
    export ZPLUG_HOME=/home/linuxbrew/.linuxbrew/opt/zplug
fi

if [[ -s "${ZPLUG_HOME}/init.zsh" ]]; then
    source $ZPLUG_HOME/init.zsh
fi

alias ll='ls -al'
alias today='date "+%Y%m%d"'
alias now='date "+%Y%m%d-%H%M%S"'
alias d='docker'
alias dc='docker-compose'
alias dcr='dc down && dc up -d'
alias gco='git co $(git b | peco)'
alias gp='git pull'
alias gpc='gb | grep '\''*'\'' | awk '\''{print $2}'\'' | xargs git push $(git remote | peco)'
alias g='git'

alias gr='git remote'
alias gs='git status'
alias gd='git diff'
alias gcf='git clean -f'
alias gc='git checkout'
alias gb='git branch'
alias gl='git log'
alias k='kubectl'
alias kd='kubectl delete'
alias kdp='kubectl delete pods'
alias kdd='kubectl delete deployments'
alias ka='kubectl apply'
alias kaf='kubectl apply -f'
alias kg='kubectl get'
alias kgp='kubectl get pods'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgn='kubectl get node'
alias ke='kubectl exec'
alias p1='awk '"'"'{print $1}'"'"''
alias p='peco'
alias sp='$(kgp|p1|p)'
alias home='ssh mosin.jp'
alias eclcore='ssh core@192.168.32.102'
alias sb='source ~/.bashrc'
alias vi='vim'
alias relog='exec $SHELL -l'
alias ..='cd ..'
alias ns='npm start'
loop () { for ((i=0;i<$1;i++)); do $2 $3; done }

export PATH=$PATH:/Users/mosin/.nodebrew/current/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
export PATH=$PATH:/Users/mosin/.flutter-system/flutter/bin
export NODE_PATH=/Users/mosin/.nodebrew/node/v11.13.0/lib/node_modules
export PATH=$PATH:$HOME/.ndenv/bin
export PATH=$PATH:/usr/local/opt

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

if type "nodenv" > /dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

bindkey -v

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
# Ctrl+rでhistoryからあいまい検索できる(peco)
function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco --layout bottom-up`
  CURSOR=$#BUFFER
  echo
  zle redisplay
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

function get-repo() {
  return $(ghq list | peco --layout bottom-up)
}

# ghqとpecoでリポジトリを検索
function ghq-repository-selection() {
 #targetDir=`get-repo`
 targetDir=$(ghq list | peco --layout bottom-up)
 if [ -n "${targetDir}" ]; then
         cd $(ghq root)/${targetDir}
 fi
 echo 
 zle reset-prompt
}
zle -N ghq-repository-selection
bindkey '^G' ghq-repository-selection

# ghqとpecoでリポジトリに遷移
function open-repository-selection() {
 targetDir=$(ghq list | peco --layout bottom-up)
 echo ${targetDir}
 if [ -n "${targetDir}" ]; then
    open -a '/Applications/Google Chrome.app' https://${targetDir}
 fi
 echo 
 zle reset-prompt
}
zle -N open-repository-selection
bindkey '^O' open-repository-selection


if type "kubectl" > /dev/null 2>&1; then
    source <(kubectl completion zsh)
fi

if type "zplug" > /dev/null 2>&1; then
    zplug "mafredri/zsh-async", from:github
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "sindresorhus/pure"
    zplug "zsh-users/zsh-autosuggestions"

    if ! zplug check --verbose; then
        zplug install
    fi

    zplug load
fi

