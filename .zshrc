export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/.nodebrew/current/bin:$PATH

alias ll='ls -al'
alias today='date "+%Y%m%d"'
alias now='date "+%Y%m%d-%H%M%S"'
alias d='docker'
alias dc='docker-compose'
alias dcr='dc down && dc up -d'
alias gco='git co $(git b | peco)'
alias gp='git pull'
alias gpc='git push -u $(git remote | peco) $(git branch --show-current)'
alias g='git'

alias gr='git remote'
alias gs='git status'
alias gd='git diff'
alias gcf='git clean -f'
alias gc='git checkout'
alias gb='git branch'
alias gl='git log'

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/f-sy-h/F-Sy-H.plugin.zsh
source ~/.zsh/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
\$ '

setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録

function peco-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco --layout bottom-up`
  CURSOR=$#BUFFER
  echo
  zle redisplay
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

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

# pecoでgoogle cloudのプロジェクトを遷移
function gpr {
  project=$(gcloud config configurations list --format=json | jq -r '.[].name' | peco)
  gcloud config configurations activate ${project}
}
zle -N gpr
bindkey '^E' gpr

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tagashira.keisuke/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tagashira.keisuke/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tagashira.keisuke/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tagashira.keisuke/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
