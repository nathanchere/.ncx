# .ncx

Just my Linux box setup / bootstrap scripts / dotfiles / etc.

Specifically assumes a Fedora-based system. Tested on:

* Korora 25 (XPS 13 9350)
* Fedora 25 (Raspberry Pi 3)

### Install

    git clone https://github.com/nathanchere/.ncx.git ~/.ncx
    cd ~/.ncx

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
* launcher - albert? dmenu?
* quakish terminal - altyo?
* stuff on k4m4-terminalsaresexy for inspiration

### Thanks / inspiration

* jaagr
* rawsh
* joedicastro
* xero

Apologies to anyone else who I've stolen from but forgotten to mention
