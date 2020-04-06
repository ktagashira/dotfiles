export LANG=ja_JP.UTF-8
PROMPT="[%n@%m %~]$ "
bindkey -v

setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt correct

autoload -Uz colors
colors

#PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
#PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
#SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
##RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"

export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

HISTFILE=~/.zsh_history

HISTSIZE=10000
SAVEHIST=10000

# 直前のコマンドの重複を削除
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 全履歴を一覧表示
function history-all { history -E 1 }

# Zshの拡張ライブラリのPATH設定
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi

# 補完機能を有効にする
autoload -Uz compinit && compinit -u

# 補完候補を一覧を表示
setopt auto_list

# 補完メニューをカーソルで選択可能にする
zstyle ':completion:*:default' menu select=1

alias ll='ls -l'
alias today='date "+%Y%m%d"'
alias now='date "+%Y%m%d-%H%M%S"'
alias d='docker'
alias dc='docker-compose'
alias dcr='dc down && dc up -d'
alias gco='git co $(git b | peco)'
#alias gpc='gb | grep '\''*'\'' | awk '\''{print $2}'\'' | xargs git push $(git remote | peco)'
alias gpc='gb | grep '\''*'\'' | awk '\''{print $2}'\'' | xargs git push origin'

alias gr='git remote'
alias gs='git status'
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
alias home='ssh -i ~/sshPasskey/koetsuki.pem mosin@mosin.jp'
alias eclcore='ssh core@192.168.32.102'
alias sb='source ~/.bashrc'
alias vi='vim'
alias relog='exec $SHELL -l'
alias ..='cd ..'
alias ns='npm start'
loop () { for ((i=0;i<$1;i++)); do $2 $3; done }

#export PATH=$PATH:/Users/mosin/.nodebrew/current/bin
export PATH=$PATH:/Users/mosin/.flutter-system/flutter/bin
export NODE_PATH=/Users/mosin/.nodebrew/node/v11.13.0/lib/node_modules
export PATH=$PATH:$HOME/.ndenv/bin

eval "$(ndenv init -)"
