# .ncx

Just my Linux box setup / bootstrap scripts / dotfiles / etc.

Specifically assumes a Fedora-based system. Tested on:

* Korora 25 (XPS 13 9350, VirtualBox)
* Fedora 25 (Raspberry Pi 3)

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

### Summary

* Display manager: LightDM
* Window manager: XMonad
* Bars/tray/etc: polybar, tint2
* Notifications: dunst
* Launcher: rofi
* Shell: fish (w/ ohmyfish)
* Terminal: terminator

### Cheat sheet

#### Key bindings

* Win+Shift+Enter : open new terminal window
* Win+[1..9] : switch to workspaces n
* Win+Shift+[1..9] : send focused window to workspace n
* Win+Space :  toggle window layout for current workspace
* Win+R : run dialog
-------
* Ctrl+`backtick` or Ctrl+Esc : drop-down terminal
* ? : kill focused window
* ? : restart Xmonad
* ? : monitor focusing
* ? : dmenu / gmrun ?

#### Shell commands

* lock : lock the desktop; password required to unlock
* reui : reload desktop candy (bars, compositor etc)
* logout : cleanly log out from Xmonad (use from rofi, not terminal)
* recoverxmonad : for when shit hits the fan; restore default Xmonad config
* uc : convert 4-character unicode value to symbol

### Misc notes

Includes various Nerd Fonts. ProggyClean or Gohu for 'bitmap' look, Iosevka preferred for everything else.

### TODO

* Better laptop sleep/resume on lid close
* remap caps lock to something not shit (probably mod key)
* LightDM greeter
* Investigate other bars and panels- taffybar, candybar, dzen, yabar, bmpanel
* Investigate misc - firejail
* xmonad screenshot / printscreen binding
* better launcher / run dialog
* xmonad mouse bindings (how to un-float?)

### Notes to me

* Interesting unicode ranges
 * 16A0 - 16F8 runes
 * 2160-2182 roman numerals
 * 2190 - 21FF arrows
 * 2200 - 2307 math symbols
 * 2308 - 23CC lines boxes misc
 * 23CF, 23E9 - 23FA - clocks and media navigation symbols
 * 244A - double slash
 * 2460-24FF numbers and letters in bubbles etc
 * 2500 - 25FF - ASCII-style geometry
 * 2600 - 2753 - weather symbols, phones, checkboxes, hazard symbols, pointing fingers, ideological symbols, chess pieces, zodiac symbols, music symbols, recycle symbols, dice, accessibility, alignment, flags, checkmarks, stars etc
 * 2754 - 27FF - fat arrows, punctuation etc
 * 2800 - 28FF - 4x2 light matrix combinations
 * 2E80 - 2EF0 - chinese characters
 * 2F00 - 2FD0 more
 * 3041 - 309F - hiragana
 * 30A0 - 30FF - katakana
 * 1f4b0 money bag
 * 1f4c8-1f4c9 trend charts
 * 1f300 - 14320 more weather symbols
 * 1f44d - 1f44e thumbs up/down

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

### Thanks / inspiration

* jaagr
* rawsh
* joedicastro
* xero
* sn0rlax

Apologies to anyone else who I've stolen from but forgotten to mention
