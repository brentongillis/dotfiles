# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-solarized-light.sh"
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-solarized-dark.sh"
# BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-google-dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

alias ls='ls --color=auto'
alias l='ls -a --color=auto'
alias ll='ls -lhA --color=auto'
alias lw='ls -l | wc -l'
alias bye='sudo shutdown now -h'
alias clc='printf "\033c"'
alias xclip='xclip -sel clipboard'
alias snooze='sudo s2ram'
alias gkey='pass vcs/github/personal_access_token | xclip'
alias ff='firefox --new-tab'
alias fuckcapslock='setxkbmap -option caps:escape'
alias ..='cd ..'
alias foxdie='killall /usr/lib64/firefox/firefox'

# funcs
function cdl() {
    cd "$1" && shift && ls "$@"
}

function cdls() {
    ( cd "$1" && shift && ls "$@" )
}

if [ -f ~/.bash_alias ]; then
    source ~/.bash_alias
fi

export PS1='\u \[\e[0;31m\][\[\e[00m\]\W\[\e[0;31m\]]\[\e[00m\] \[\e[0;35m\]>>\[\e[00m\] '
# export PS1='\[\e[0;31m\][\[\e[00m\]\W\[\e[0;31m\]]\[\e[00m\] \[\e[0;35m\]>>\[\e[00m\] '
export EDITOR=vim
export VISUAL=vim
# export TERMINAL=st
# export TERMINAL=urxvt
export PAGER=less

# st delete key fix. See ~/.inputrc also
if [ $TERM = "st-256color" ]; then
    tput smkx
fi
HISTTIMEFORMAT="%y-%m-%d %T "

# export PATH="$PATH:$LOCAL_BIN:$GOPATH/bin:$HOME/.cargo/bin:$HOME/.npm-global/bin"
export GOPATH="/home/brenton/go"
export LOCAL_BIN="/home/brenton/.bin:/home/brenton/.local/bin"

#remove duped entries in PATH. Thanks to the Linux Journal reader pepa65
export IPATH="$HOME/.cargo/bin:${PATH}:$LOCAL_BIN:$GOPATH/bin:$HOME/.npm-global/bin"
export PATH=$(n= IFS=':'; for e in $IPATH; do [[ :$n == *:$e:* ]] || n+=$e:;done;echo "${n:0: -1}")

# needed to compile against the mongodb c driver
#export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig"

# very old tensorflow stuff
# export LIBRARY_PATH=${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow
# export LD_LIBRARY_PATH=${GOPATH}/src/github.com/tensorflow/tensorflow/bazel-bin/tensorflow
eval $(dircolors -b)

export QT_QPA_PLATFORMTHEME="qt5ct"

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# man() {
#     env \
#         LESS_TERMCAP_mb=$(printf "\e[1;31m") \
#         LESS_TERMCAP_md=$(printf "\e[1;31m") \
#         LESS_TERMCAP_me=$(printf "\e[0m") \
#         LESS_TERMCAP_se=$(printf "\e[0m") \
#         LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
#         LESS_TERMCAP_ue=$(printf "\e[0m") \
#         LESS_TERMCAP_us=$(printf "\e[1;32m") \
#             man "$@"
# }
