#!/bin/bash

# backlight code from https://launchpadlibrarian.net/231218203/xps13-kbd-backlight

#~ ## 0 : off
#~ ## 1 : min
#~ ## 2 : max

# usable at resume|thaw linking it in /etc/pm/sleep.d
# [ln -s  /usr/bin/xps13-kbd-backlight /etc/pm/sleep.d/20_xps13-kbd-backlight]

# /sys/class/leds/dell::kbd_backlight/brightness

backlightOn() {
  echo 2 | sudo dd of=/sys/class/leds/dell\:\:kbd_backlight/brightness
}

backlightOff() {

}

wirelessOn() {

}

wirelessOff() {

}
