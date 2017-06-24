# .ncx

Just my Linux box setup / bootstrap scripts / dotfiles / etc.

Specifically assumes a Fedora-based system. Tested on:

* Korora 24, 25 (XPS 13 9350, VirtualBox)
* Fedora 25 (Raspberry Pi 3)

... and found to be horribly inconsistent and buggy. Currently working on compatibility with:

* Arch (circa 2017-05)
* Manjaro 17.0.1

 There are some things which I suspect might cause issues with different language or regional settings, like string comparison to check if a package is installed on Fedora sytstems. So to that end, assume if your system language is anything other than English things will break.

 Caveat emptor.

### Install

    git clone https://github.com/nathanchere/.ncx.git ~/.ncx
    cd ~/.ncx

    sudo ./ncx install

From there

    ./init_dotfiles.sh
    ./init_fonts.sh

    ./install_[whatever].sh

These docs are shit but what can you do?

Manual things required:

* Excercism key from http://www.exercism.io/account/key
* Git user/pass for Github for uploading SSH public key

Issues:

* if config already exists (e.g. atom creates own on install), what to do?
* --force flag for above?

### Summary

* Display manager: LightDM
* Window manager: XMonad
* Bars/tray/etc: polybar, tint2
* Notifications: dunst
* Launcher: rofi
* Shell: fish (w/ ohmyfish)
* Terminal: terminator (main), urxvt (scratchpad)

### Cheat sheet

#### Input bindings

* Win+Shift+Enter : open new terminal (terminator)
* Win+[1..9] : switch to workspaces n
* Win+Shift+[1..9] : send focused window to workspace n
* Win+Space :  toggle window layout for current workspace
* Win+R : run dialog (rofi)
* Win+\` : drop-down terminal (urxvt)
---
* Win+`Left Click` : drag to un-tile and freely position selected window
* Win+`Right Click` : drag to resize selected window
* Win+T : re-tile focused floating window
---
* VolumeUp : increase volume by 5%
* VolumeDown : decrease volume by 5%
* Ctrl+VolumeUp : set volume to maximum
* Ctrl+VolumeDown : set volume to minimum
* BrightnessUp : increase backlight brightness by 5%
* BrightnessDown : decrease backlight brightness by 5%
* Ctrl+BrightnessUp : set backlight brightness to maximum
* Ctrl+BrightnessDown : set backlight brightness to minimum
---
* Win+Q : recompile / restart Xmonad
-------
* Win+Shift+C : kill focused window
* ? : monitor focusing
* ? : dmenu / gmrun ?

#### Useful ncx-specific tools

* lock : lock the desktop; password required to unlock
* reui : reload desktop candy (bars, compositor etc)
* logout : cleanly log out from Xmonad (use from rofi, not terminal)
* recoverxmonad : for when shit hits the fan; restore default Xmonad config
* uc : convert 4-character unicode value to symbol
* ucc : convert 4-character unicode value to symbol and copy to X clipboard
* light : easier alternative to /sys/class/backlight/* or xrandr for controlling backlight
  - `light -max` - set backlight to 100%
  - `light -min` - set backlight to minimum visible strength (i.e. not absolute zero)
  - `light -inc 25` - increase backlight strength by 25%
  - `light -dec 10` - decrease backlight strength by 10%
  - `light -get` - decrease backlight strength by 10%
  More options available with `light -help`
* wifi : wrapper around nmcli for easier adhoc WiFi connection and keeping passwords out
  of your terminal history.

#### Useful generic tools

* `arandr` : simple GUI around xrandr for display management
* `nmcli` : network manager CLI, useful for easy WiFi management
  - `nmcli device wifi` to list available WiFi connections
  - `nmcli c` to list saved WiFi connections
  - `nmcli c up <name>` to connecto to a saved WiFi connection
  - `nmcli c add con-name <hotspotname> type wifi ifname wlp58s0 ssid <hotspotname>` connect to new hotspot, then `nmcli c up <name>` - wtf this is bullshit... needs to be made less bullshit
* `screenfetch` / `sysinfo` - both half-measures but OK for quick system info
* `ncdu` - disk usage explorer
* `remmina` - pretty versatile RDP/VNC/etc-in-one client
* `nnn` - terminal file browser

### Misc notes

Includes various Nerd Fonts. ProggyClean or Gohu for 'bitmap' look, Iosevka preferred for everything else.

### TODO

* Wifi connection script
* Monitor connection script
* Better screen capture
* Better laptop sleep/resume on lid close
* remap caps lock to something not shit (probably mod key)
* LightDM greeter
* Investigate other bars and panels- taffybar, candybar, dzen, yabar, bmpanel
* Investigate misc - firejail
* better launcher / run dialog
* use `trash` instead of rm
* screen locking - xautolock ?

### Notes to me
* dm-tool for bringing up lightdm
* rss on launch
* docker (firejail?)
* fish aliases
* pgp / gpg
* music - cmus/cmus-remote?
* weechat
* icon packs
* taskwarrior or similar
* termite, urvxt?
* refactor installers for common GitHub releases installer script
* vodik xmonad
* replace figlet with toilet?
* * add ASDF to bash and fish
* feed reader - newsbueter? Termfeed? snownews? turses?
* Email - mutt?
* Some kind of start page
* noice, rover, ranger, mc
* launcher - albert? dmenu? synapse?
* quakish terminal - altyo?
* stuff on k4m4-terminalsaresexy for inspiration
* udiskie (usb mounting etc)
* notify-osd, statnot
* ssh-agent, gpg-agent
* helper function to get latest tags and releases from github by project
* clean xmonad quit script -= https://github.com/thblt/DotFiles/blob/master/.xmonad/quit-xmonad.sh
* openvpn
* good xmonad multimon setup https://github.com/IvanMalison/dotfiles/blob/d49eb65e7eb06cff90e171c0f5c44d4dae3a5510/dotfiles/xmonad/xmonad.hs#L671
* gem install lolcat
* xmonad inspirat https://www.youtube.com/watch?v=70IxjLEmomg&feature=youtu.be
* dots https://github.com/OrionDB5/dotfiles
* xmonad conf https://static.charlieharvey.org.uk/src/xmonad.hs.txt
* mreq dotfiles for monitor management script select_display

* rebg and reui into script for turn bars on/off, specify wallp category etc
* script for wifi management easier than nmcli
* sysinfo and screenfetch into something better
*

### Thanks / inspiration

* jaagr
* rawsh
* joedicastro
* xero
* sn0rlax
* leoxiong

Apologies to anyone else who I've stolen from but forgotten to mention
