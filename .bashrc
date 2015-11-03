# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BASE16_SHELL="$HOME/.config/base16-shell/base16-eighties.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

alias ls='ls --color=auto'
alias l='ls -a --color=auto'
alias ll='ls -la --color=auto'
alias lw='ls -l | wc -l'
alias newest='ls -1t | head -1'
alias oldest='ls -1t | tail -1'
alias red='redshift -l 30.6:-87.0 -t 5700:4400 -g 0.8 -m vidmode &'
alias redDead='killall redshift'
alias bye='sudo shutdown now'
alias clc='printf "\033c"'
alias cdc='cd && clc'
alias m='mocp'

if [ -f ~/.bash_alias ]; then
    source ~/.bash_alias
fi

export PS1='\u \[\e[0;31m\][\[\e[00m\]\W\[\e[0;31m\]]\[\e[00m\] \[\e[0;35m\]>>\[\e[00m\] '
export EDITOR=vim
export VISUAL=vim
HISTTIMEFORMAT="%y-%m-%d %T "
export RUST_SRC_PATH=/usr/src/rust/src
# needed to compile against the mongodb c driver
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/lib/pkgconfig"
PATH="${PATH}:/home/brenton/.bin"
eval $(dircolors -b)
