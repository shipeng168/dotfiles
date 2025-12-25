ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp)
source $OMZ/zsh-autosuggestions/zsh-autosuggestions.zsh
source $OMZ/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source $OMZ/p9k.zsh
#source $OMZ/powerlevel9k/powerlevel9k.zsh-theme
source $OMZ/p10k.zsh
source $OMZ/powerlevel10k/powerlevel10k.zsh-theme

autoload -U colors && colors
#autoload -Uz compinit && compinit

setopt correct
setopt pushdminus
setopt append_history
setopt histignorealldups
setopt inc_append_history

zstyle ':completion:*' menu select=2
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=* l:|=*'

alias -g ..='cd ../'
alias -g ...='cd ../../'

alias -- -='cd -'
for i in {1..19}
do
    alias $i="cd -$i"
done

alias md='mkdir -p'
alias rd='rmdir'
alias d='dirs -v'

# List directory contents
alias ls='eza --icons=always --color=always --no-user -s new'
alias l='ls -AF --classify=always'
alias l.='ls -dS .*'
alias ll='ls -l'
alias la='ls -A'
alias llf='ls -Alf'
alias lld='ls -ADl'
alias lf='ls -Al|grep ^\-'
alias lsd='ls -Al|grep ^d'
alias lla='ls -lA'

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n30
}

function take() {
  mkdir -p $1
  cd $1
}

function open_command() {
  emulate -L zsh
  setopt shwordsplit

  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   [[ $(uname -a) =~ "Microsoft" ]] && \
                open_cmd='cmd.exe /c start' || \
                open_cmd='xdg-open' ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # don't use nohup on OSX
  if [[ "$OSTYPE" == darwin* ]]; then
    $open_cmd "$@" &>/dev/null
  else
    nohup $open_cmd "$@" &>/dev/null
  fi
}

function default() {
    test `typeset +m "$1"` && return 0
    typeset -g "$1"="$2"   && return 3
}

function env_default() {
    env | grep -q "^$1=" && return 0
    export "$1=$2"       && return 3
}

cl() {
    if [[ $1 == "" ]]
    then
        cd ~ && ll
    else
        cd "$1" && ls
    fi
}
del() { mv "$@" ~/Trash;}
stp() { scp "$@" shipeng: && mkdir -p tmp && mv "$@" tmp;}
psgrep() {
    ps -ef | grep -v grep | grep "$@"
}
baidu() {
    xdg-open "https://www.baidu.com/s?wd=$1"
}
google() {
    xdg-open "https://www.google.com/search?q=$1"
}
googletranslate() {
    xdg-open "https://translate.google.cn/#view=home&op=translate&sl=auto&tl=zh-CN&text=$1"
}
