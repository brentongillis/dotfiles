#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
setxkbmap -option caps:escape
exec i3
