# .ncx

Just my Linux box setup / bootstrap scripts / dotfiles / etc.

Specifically assumes a Fedora-based system. Tested on:

* Korora 25 (XPS 13 9350)
* Fedora 25 (Raspberry Pi 3)

### Install

    git clone https://github.com/nathanchere/.ncx.git ~/.ncx
    cd ~/.ncx

    sudo ./ncx install

From there

    ./init_dotfiles.sh
    ./init_fonts.sh

    ./install_[whatever].sh

### TODO

* Notification support (dunst? twmn? statnot?)
* Tracking current workspace
* LightDM greeter
* Clean logout/etc without mate-panel
* Investigate other bars and panels- taffybar, candybar, dzen, yabar, tint2, bmpanel
* Investigate misc - firejail
* Add .utils to fishrc etc
* easier way to maintain dots etc ongoing

### Notes to me

* dm-tool for bringing up lightdm
* rss on launch
* docker (firejail?)
* fish aliases
* * pgp / gpg
* git config
* music - cmus/cmus-remote?
* Nerdfonted Dina or Gohufont?
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

### Thanks / inspiration

* jaagr
* rawsh
* joedicastro
* xero

Apologies to anyone else who I've stolen from but forgotten to mention
