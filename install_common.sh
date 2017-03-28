#!/bin/bash

. "./_.sh"

requireRoot

main() {
  dnf install -y automake autoconf readline-devel ncurses-devel openssl-devel
  dnf install -y libyaml-devel libxslt-devel libffi-devel libtool unixODBC-devel

  dnf install -y lightdm-webkit2-greeter
  dnf install -y fish terminator
  dnf install -y lshw nmap net-tools
  dnf install -y feh i3lock scrot ImageMagick lightdm-webkit-greeter compton
  dnf install -y tint2 rofi polybar
  dnf install -y htop neofetch cmatrix
  dnf install -y lynx
  dnf install -y figlet ddate
  dnf install -y docker

  dnf install -y xmonad ghc-xmonad-contrib ghc-xmonad-devel ghc-xmonad-contrib-devel

  dnf install -y gem ruby python python3 python3-wheel
  gem install lolcat
}

main 2>&1 |& tee -a "$LOGFILE"
