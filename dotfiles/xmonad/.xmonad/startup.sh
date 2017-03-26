#!/bin/bash

killall -q polybar compton

while pgrep -x polybar >/dev/null; do sleep 1; done
while pgrep -x compton >/dev/null; do sleep 1; done
notify-send "compton"
compton &
polybar top &
polybar bottom &
notify-send "bottom"
