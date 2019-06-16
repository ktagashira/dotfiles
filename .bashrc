
#CentOS向けのbashrc読み込み
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias ll='ls -l'
alias today='date "+%Y%m%d"'
alias now='date "+%Y%m%d-%H%M%S"'
alias d='docker'
alias dc='docker-compose'
alias dcr='dc down && dc up -d'
alias gco='git co $(git b | peco)'
alias gs='git status'
alias gcf='git clean -f'
alias gb='git branch'
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
alias home='ssh -i ~/id_rsa mosin@mosin.jp'
alias sb='source ~/.bashrc'
alias vi='/usr/local/bin/vim'


