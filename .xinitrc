#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -load ~/.Xresources
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --output eDP-1-1 --primary
setxkbmap -option caps:escape
/home/brenton/.bin/pclip start
exec i3
