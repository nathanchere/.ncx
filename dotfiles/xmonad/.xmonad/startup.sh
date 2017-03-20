notify-send 123
#killall -q polybar compton
sleep 3
notify-send 456
exit

sleep 1
compton --config "$HOME/.config/compton.conf" -b &
echo 1
sleep 1
dunst &
echo 2
notify-send "Alive" &
sleep 1
echo 3
notify-send "It's alive" &
polybar top &
echo 4
sleep 1

polybar bottom &
echo 5
sleep 1
notify-send "Hahaha" &
echo 6
