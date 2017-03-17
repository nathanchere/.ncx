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
* Investigate other bars - taffybar, candybar, dzen
* Investigate misc - firejail

### Notes to me

* dm-tool for bringing up lightdm 
