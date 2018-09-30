
#CentOS向けのbashrc読み込み
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

alias ll='ls -l'
alias today='date "+%Y%m%d"'
alias now='date "+%Y%m%d-%H%M%S"'
alias d='docker'
alias dc='docker-compose'

