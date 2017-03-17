#!/bin/bash

#ICON=$HOME/.xlock/icon.png
BKGFILENAME="$(mktemp).png"
scrot "$BKGFILENAME"

# Essentially pixelate 10x10
convert "$BKGFILENAME" -scale 10% -scale 1000% "$BKGFILENAME"

#concert "$BKGFILENAME" "$ICON" -gravity center -composite -matte "$BKGFILENAME"

i3lock -u -i "$BKGFILENAME"
