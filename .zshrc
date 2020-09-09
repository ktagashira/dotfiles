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
alias kc='kubectl config'
alias kcc='kubectl config current-context'
alias kg='kubectl get'
alias kgp='kubectl get pods -o wide'
alias kgd='kubectl get deployments'
alias kgs='kubectl get services'
alias kgn='kubectl get node'
alias ke='kubectl exec'
alias b='bpctl'
alias b2='bpctl2'
alias p1='awk '"'"'{print $1}'"'"''
alias p='peco'
alias pc='pbcopy'
alias pp='pbpaste'
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
bindkey "^?" backward-delete-char

# 履歴共有
setopt share_history

# マッチしたコマンドのヒストリを表示できるようにする
# # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups

# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space

# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# 古いコマンドと同じものは無視
setopt hist_save_no_dups

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 補完時にヒストリを自動的に展開
setopt hist_expand

# 履歴をインクリメンタルに追加
setopt inc_append_history
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

zplug "mafredri/zsh-async", from:github
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "sindresorhus/pure"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"

#: "cd先のディレクトリのファイル一覧を表示する" && {
#  [ -z "$ENHANCD_ROOT" ] && function chpwd { tree -L 1 } # enhancdがない場合
#  [ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="tree -L 1" # enhancdがあるときはそのHook機構を使う
#}

#: "sshコマンド補完を~/.ssh/configから行う" && {
#  function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' |  awk '{print $2}' | sort) }
#}

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryofuji/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ryofuji/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryofuji/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ryofuji/google-cloud-sdk/completion.zsh.inc'; fi

autoload -U promptinit; promptinit

zstyle :prompt:pure:path color cyan

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PROMPT='$(kube_ps1)'$PROMPT
PURE_PROMPT_SYMBOL=" $ "

open-alias() {
    if [ -z "$RBUFFER" ] ; then
        open-alias-aux
    else
        zle end-of-line
    fi
}

open-alias-aux() {
    str=${LBUFFER%% }
    bp=$str
    str=${str##* }
    targets=`alias ${str}`
    if [ $targets ]; then
        cmd=`echo $targets|cut -d"=" -f2`
        LBUFFER=${cmd//\'/}
    fi
}

zle -N open-alias
#bindkey "^E" end-of-line
bindkey "^E" open-alias
