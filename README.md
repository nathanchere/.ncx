# .ncx

Just my Linux box setup / bootstrap scripts / dotfiles / etc.

Originally for Fedora-based systems only. Currently tested and working targets:

* Fedora family
    * Korora 24, 25 (XPS 13 9350, VirtualBox)
    * Fedora 25, 26 (Raspberry Pi 3)    
* Arch family
    * Arch (circa 2017-05) (XPS 13 9350, VirtalBox)
    * Manjaro 17.0.1, 17.3 (VirtualBox)

Work-in-progress:

* NixOS 17.03 (VirtualBox) (tonnes of things not working)
* Debian and [n]buntu variants (very early stages)

Also assumes system language is set to English, otherwise many things will
break and I have no interest in fixing these.

As always, caveat emptor.

### Install

#### Bootstrap

First clone locally and run the bootstrapper:

    git clone https://github.com/nathanchere/.ncx.git ~/.ncx
    cd ~/.ncx
    sudo ./install.sh

This will:

* initialise a config file for the `ncx` tool
* install various common dependencies
* configure udev rules
* install fish (with oh-my-fish and various plugins)
* set the default shell for the current user to be fish
* add `$HOME/.ncx/system/bin` to $PATH via profiles.d

If something breaks unexpectedly try instead running as:

    sudo ./install.sh debug

#### Post-bootstrap

TODO: outdated

From there:

    ~./init_dotfiles.sh~
    ~./init_fonts.sh~
    ~./install_[whatever].sh~

These docs are shit *and outdated now* but what can you do?

Manual things required:

* Excercism key from http://www.exercism.io/account/key
* Git user/pass for Github for uploading SSH public key

### Configuration Summary

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
* rebg : change to a new random background wallpaper
* logout : cleanly log out from Xmonad (use from rofi or dmenu, not terminal)
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

### Thanks / inspiration

Various dotfiles, skins, colour themes, xmonad configurations and helper scripts inspired by, adapted from or otherwise stolen from:

* jaagr
* rawsh
* joedicastro
* xero
* sn0rlax
* leoxiong
* ethanschoonover

References which helped me a lot along the way:

* bash
    * https://dev.to/thiht/shell-scripts-matter
    * http://robertmuth.blogspot.se/2012/08/better-bash-scripting-in-15-minutes.html
    * https://jvns.ca/blog/2017/03/26/bash-quirks/
    * http://bash3boilerplate.sh/


Apologies to anyone else who I've stolen from but forgotten to mention
