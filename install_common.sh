#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf copr enable -y kzmd/compton
  dnf copr enable -y konimex/neofetch
  dnf copr enable -y youssefmsourani/telegram-desktop
  dnf copr enable -y antergos/lightdm-webkit2-greeter
  dnf copr enable -y baoboa/cmatrix
  #dnf copr enable -y baoboa/cool-retro-term # No support for Fedora 25

  # TODO: Optimise this

  dnf install -y automake autoconf readline-devel ncurses-devel openssl-devel
  dnf install -y libyaml-devel libxslt-devel libffi-devel libtool unixODBC-devel

  #polybar dependencies
  dnf install -y cmake @development-tools gcc-c++ cairo-devel xcb-proto xcb-util-devel xcb-util-wm-devel xcb-util-image-devel

  dnf install -y fish terminator
  dnf install -y lshw nmap
  dnf install -y feh i3lock scrot ImageMagick lightdm-webkit-greeter compton
  dnf install -y tint2
  dnf install -y htop neofetch cmatrix
  dnf install -y lynx
  dnf install -y figlet ddate
  dnf install -y docker

  dnf install -y xmonad ghc-xmonad-contrib ghc-xmonad-devel ghc-xmonad-contrib-devel

  dnf install -y gem
  gem install lolcat
}

main 2>&1 |& tee -a "$LOGFILE"
