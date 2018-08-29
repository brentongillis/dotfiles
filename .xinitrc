#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -load ~/.Xresources
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
setxkbmap -option caps:escape
# exec dwm
exec i3
