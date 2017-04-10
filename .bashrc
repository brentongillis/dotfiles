# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-eighties.sh"
#BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-google-dark.sh"
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-google-light.sh"
#BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-ocean.sh"
#BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-solarized-light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

alias ls='ls --color=auto'
alias l='ls -a --color=auto'
alias ll='ls -la --color=auto'
alias lw='ls -l | wc -l'
alias red='redshift -l 30.6:-87.0 -t 5700:4400 -g 0.8 -m vidmode &'
alias redDead='killall redshift'
alias bye='sudo shutdown now -h'
alias clc='printf "\033c"'
alias cdc='cd && clc'
alias xclip='xclip -sel clipboard'

if [ -f ~/.bash_alias ]; then
    source ~/.bash_alias
fi

export PS1='\u \[\e[0;31m\][\[\e[00m\]\W\[\e[0;31m\]]\[\e[00m\] \[\e[0;35m\]>>\[\e[00m\] '
export EDITOR=vim
export VISUAL=vim
HISTTIMEFORMAT="%y-%m-%d %T "

# needed to compile against the mongodb c driver
#export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig"
export GOPATH=/home/brenton/go
PATH=$PATH:/home/brenton/.bin:$GOPATH/bin
eval $(dircolors -b)

man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
